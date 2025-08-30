import { openBrowser } from "./browser.ts";
import { getCLIArgs } from "./cli-args.ts";
import { app } from "./app.ts";

const { port, "open-browser": isOpenBrowser, title } = getCLIArgs();

app({ port, title });

if (isOpenBrowser) {
  openBrowser(`http://localhost:${port}/`);
}
