package;

import Console;

class Error
{
	public function new(message:String, logOutput:Bool = false)
	{
		Console.errorPrefix = "<b,red>Error:<//> ";
		Console.error('<b,gray>$message<//>');

		if (logOutput)
			Sys.command('cd ./logs && echo "[${Date.now();}]\n$message" > ${Date.now().toString().split(" ")[0]}.log');

		Sys.exit(1);
	}
}
