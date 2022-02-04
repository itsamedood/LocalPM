package;

import Cli;

final class Lpm
{
	public static var username(get, never):String;

	public static inline final VERSION:String = "v2";

	public static inline function main():Void
	{
		Cli.getArgs();
	}

	@:noCompletion
	private static inline function get_username():Null<String>
	{
		final env:Map<String, String> = Sys.environment();

		if (Sys.systemName() == "Windows")
			env.exists("USERNAME") ? return env.get("USERNAME") : return null;
		else
			env.exists("USER") ? return env.get("USER") : return null;
	}
}
