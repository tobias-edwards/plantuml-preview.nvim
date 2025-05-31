const bindHandlers = (ws: WebSocket) => {
  ws.onopen = () => {
    // NOTE: Output signals to Neovim client that connection is successful
    console.log("CONNECTED");
  };
  ws.onmessage = (event) => {
    console.log(`RECEIVED: ${event.data}`);
  };
  ws.onclose = () => {
    console.log("DISCONNECTED");
  };
  ws.onerror = (error) => {
    console.error("ERROR:", error);
  };
};

export const app = ({ port }: { port: number }) => {
  let ws: WebSocket;

  Deno.serve({
    port,
    handler: async (request) => {
      if (request.headers.get("upgrade") === "websocket") {
        const { socket, response } = Deno.upgradeWebSocket(request);
        ws = socket;
        bindHandlers(ws);
        return response;
      }

      const url = new URL(request.url);

      if (request.method === "PUT" && url.pathname === "/image") {
        const imageUrl = new URLSearchParams(url.search).get("url");
        const payload = { data: { url: imageUrl } };
        if (ws && imageUrl) {
          ws.send(JSON.stringify(payload));
        }
        return new Response();
      } else if (request.method === "GET" && url.pathname === "/image") {
        const imageUrl = new URLSearchParams(url.search).get("url");
        if (!imageUrl) {
          return new Response("Missing url arg");
        }
        const img = await Deno.readFile(imageUrl);
        return new Response(img, {
          headers: {
            "Content-Type": "image/png",
          },
        });
      } else if (request.method === "PUT" && url.pathname === "/error") {
        const errorMessage = new URLSearchParams(url.search).get("message");
        const payload = { error: { message: errorMessage } };
        if (ws) {
          ws.send(JSON.stringify(payload));
        }
        return new Response();
      } else {
        const decoder = new TextDecoder("utf-8");
        const data = await Deno.readFile("./index.html");
        let html = decoder.decode(data);
        html = html.replaceAll("{{PORT}}", port.toString());
        return new Response(html, {
          headers: {
            "Content-Type": "text/html",
          },
        });
      }
    },
  });
};
