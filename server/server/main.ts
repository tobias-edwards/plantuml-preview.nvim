import { openBrowser } from "./browser.ts";
import { getCLIArgs } from "./cli-args.ts";
import { app } from "./app.ts";

const { port, "open-browser": isOpenBrowser } = getCLIArgs();

app({ port });

if (isOpenBrowser) {
  openBrowser(`http://localhost:${port}/`);
}
