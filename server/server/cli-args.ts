import { parseArgs } from "jsr:@std/cli/parse-args";

type CLIArgs = {
  "open-browser": boolean;
  port: number;
  title: string;
};

export const getCLIArgs = () => {
  const args: CLIArgs = parseArgs(Deno.args, {
    boolean: ["open-browser"],
    default: { "open-browser": true, port: 2345, title: "Title" },
  });

  const { port, title } = args;

  if (!Number.isInteger(port)) {
    throw new Error(`Invalid port: ${port}`);
  }

  return { "open-browser": args["open-browser"], port, title };
};
