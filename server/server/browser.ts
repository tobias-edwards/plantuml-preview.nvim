export const openBrowser = (url: string) => {
  const command = new Deno.Command("open", {
    args: [url],
    stdin: "piped",
    stdout: "piped",
  });
  return command.spawn();
};
