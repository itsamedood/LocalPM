package;

class Success
{
	public function new(message:String)
	{
		Console.logPrefix = "";
		Console.log('<b,green>$message<//>');
		Sys.exit(0);
	}
}
