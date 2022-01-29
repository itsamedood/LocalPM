package;

import Error;
import haxe.Exception;
import sys.FileSystem;
import sys.io.File;

using StringTools;

// pm set -pw demapples21 -pr github -un itsamedood -ea itsamedood@gmail.com
final class Manager
{
	public static inline function main():Void
	{
		getArgs();
	}

	private static function getArgs():Map<String, Any>
	{
		var passwordSet:Bool = false;
		var parentSet:Bool = false;
		var emailSet:Bool = false;
		var usernameSet:Bool = false;

		final args:Array<String> = Sys.args();
		final argsMap:Map<String, Any> = new Map<String, String>();

		if (args[0] == null)
			new Error("No command given. Run 'pm help' for a list of all commands.");
		else if (args[0] == "help")
		{
			switch (args[1])
			{
				case "set":
					Sys.println("Sets a new data set.");
					Sys.println("ARGUMENTS");
					Sys.println("=========");
					Sys.println("--parent | -pr <parent> : Sets the parent, AKA the app or site this data is for.");
					Sys.println("--email | -ea <email-address> : Sets the email for this app / site.");
					Sys.println("--un | -un <username> : Sets the username for this app / site.");
					Sys.println("--password | -pw <password> : Sets the password for this app / site.");
				case "get":
					Sys.println("Gets a set of data.");
					Sys.println("ARGUMENTS");
					Sys.println("=========");
					Sys.println("<parent>");
				case "edit":
					Sys.println("Edits a set of data (2 at most.)");
					Sys.println("ARGUMENTS");
					Sys.println("=========");
					Sys.println("<parent>");
					Sys.println("--parent | -pr <parent> : Edits the parent, AKA the app or site this data is for.");
					Sys.println("--email | -ea <email-address> : Edits the email for this app / site.");
					Sys.println("--un | -un <username> : Edits the username for this app / site.");
					Sys.println("--password | -pw <password> : Edits the password for this app / site.");
				case "delete":
					Sys.println("Deletes a set of data.");
					Sys.println("ARGUMENTS");
					Sys.println("=========");
					Sys.println("<parent>");
				case "list":
					Sys.println("Lists all data-set parents.");
					Sys.println("No arguments.");
				case "setup":
					Sys.println("Sets up the password manager to work. This can also be used for troubleshooting.");
					Sys.println("No arguments.");
				case "del-logs":
					Sys.println("Deletes all logs (if any.)");
					Sys.println("No arguments.");
				case "wipe":
					Sys.println("Erases ALL data-sets. This is irreversible.");
					Sys.println("No arguments.");
				case "help":
					Sys.println("Displays a list of all commands or a description with arguments for a specific command.");
					Sys.println("ARGUMENTS");
					Sys.println("=========");
					Sys.println("[command]");
				default:
					Sys.println("COMMANDS");
					Sys.println("========");
					Sys.println("set");
					Sys.println("get");
					Sys.println("edit");
					Sys.println("delete");
					Sys.println("list");
					Sys.println("setup");
					Sys.println("del-logs");
					Sys.println("wipe");
					Sys.println("help");
					Sys.println("========");
					Sys.println("You can also do: pm help <command>");
			}

			Sys.exit(0);
		}
		else if (args[0] == "set")
		{
			if (Sys.args().length < 2)
				new Error("Too few arguments given for set command.");

			for (i in 1...args.length) // starts at 1 because 0 is "set".
			{
				// PR
				if (args[i] == "--parent" || args[i] == "-pr")
					args[i + 1] != null ? !args[i + 1].startsWith("-") ? {
						!parentSet ? {
							argsMap.set("PR", args[i + 1]);
							parentSet = true;
						} : new Error("Cannot set parent twice.");
					} : new Error('Unexpected "-"') : new Error("Expected an argument after flag.");
				// EA
				else if (args[i] == "--email" || args[i] == "-ea")
					args[i + 1] != null ? !args[i + 1].startsWith("-") ? {
						!emailSet ? {
							argsMap.set("EA", args[i + 1]);
							emailSet = true;
						} : new Error("Cannot set email twice.");
					} : new Error('Unexpected "-"') : new Error("Expected an argument after flag.");
				// UN
				else if (args[i] == "--username" || args[i] == "-un")
					args[i + 1] != null ? !args[i + 1].startsWith("-") ? {
						!usernameSet ? {
							argsMap.set("UN", args[i + 1]);
							usernameSet = true;
						} : new Error("Cannot set username twice.");
					} : new Error('Unexpected "-"') : new Error("Expected an argument after flag.");
				// PW
				else if (args[i] == "--password" || args[i] == "-pw")
					args[i + 1] != null ? !args[i + 1].startsWith("-") ? {
						!passwordSet ? {
							argsMap.set("PW", args[i + 1]);
							passwordSet = true;
						} : new Error("Cannot set password twice.");
					} : new Error('Unexpected "-"') : new Error("Expected an argument after flag.");
				else
					!args[i - 1].startsWith("-") ? new Error('Unexpected ${args[i]}') : continue;
			}

			if (!argsMap.exists("PR"))
				new Error("No parent given.");
			else if (!argsMap.exists("EA"))
				new Error("No email given.");
			else if (!argsMap.exists("UN"))
				new Error("No username given.");
			else if (!argsMap.exists("PW"))
				new Error("No password was given.");

			Converter.setData(argsMap.get("PR"), argsMap.get("EA"), argsMap.get("UN"), argsMap.get("PW"));
		}
		else if (args[0] == "get")
		{
			if (Sys.args().length < 2)
				new Error("Missing argument 'parent'");
			else if (Sys.args().length > 2)
				new Error("Too many arguments given for get command.");
			else if (File.getContent("./bin/PW.bin").length < 1)
				new Success("No passwords to get.");
			else
			{
				Console.logPrefix = "";
				Console.log(Converter.getData(Sys.args()[1]));
				Sys.exit(0);
			}
		}
		else if (args[0] == "edit")
		{
			if (Sys.args().length > 6)
				new Error("Too many arguments given for edit command.");
			else if (Sys.args().length < 2)
				new Error("Too few arguments given for edit command.");

			if (Converter.checkExistanceOfData(Sys.args()[1]))
			{
				final data:Array<String> = Converter.getData(Sys.args()[1], true).split("->");

				for (a in 2...Sys.args().length)
				{
					if (Sys.args()[a] == "--parent" || Sys.args()[a] == "-pr")
						data[0] = Sys.args()[a + 1];
					else if (Sys.args()[a] == "--email" || Sys.args()[a] == "-ea")
						data[1] = Sys.args()[a + 1];
					else if (Sys.args()[a] == "--username" || Sys.args()[a] == "-un")
						data[2] = Sys.args()[a + 1];
					else if (Sys.args()[a] == "--password" || Sys.args()[a] == "-pw")
						data[3] = Sys.args()[a + 1];
					else
						!args[a - 1].startsWith("-") ? new Error('Unexpected ${args[a]}') : continue;
				}

				try
				{
					Converter.deleteData(Sys.args()[1], true);
					Converter.setData(data[0], data[1], data[2], data[3], true);

					new Success('Successfully updated "${Sys.args()[1]}"!');
				}
				catch (e:Exception)
					new Error('Failed to update "${Sys.args()[1]}": $e', true);
			}
		}
		else if (args[0] == "delete")
		{
			if (Sys.args().length < 2)
				new Error("Missing argument 'parent'");
			else if (Sys.args().length > 2)
				new Error("Too many arguments given for delete command.");
			else if (File.getContent("./bin/PW.bin").length < 1)
				new Success("No passwords to delete.");
			else
				Converter.deleteData(Sys.args()[1]);
		}
		else if (args[0] == "list")
		{
			if (Sys.args().length > 1)
				new Error("Too many arguments given for list command.");

			final contents:String = File.getContent("./bin/PW.bin");

			if (contents.length < 1)
				new Success("No passwords have been added... yet!");

			final lfSplit:Array<String> = contents.split("\n");

			for (line in lfSplit)
				line != "" ? {
					Console.logPrefix = "<b,gray>-<//> ";
					Console.log('<yellow>${Converter.decodeData(line.split("%")[0])}</>');
				} : break;
		}
		else if (args[0] == "setup")
		{
			if (FileSystem.exists("./bin"))
				Sys.println("Output directory 'bin' already exists.");
			else
				try
				{
					Sys.command("mkdir", ["bin"]);
					Sys.println("Created directory 'bin'.");
				}
				catch (e:Exception)
					new Error('Failed to create bin directory: $e', true);

			if (FileSystem.exists("./bin/PW.bin"))
				Sys.println("Output file 'PW.bin' already exists.");
			else
				try
				{
					Sys.command("cd bin && touch PW.bin");
					Sys.println("Created file 'PW.bin'.");
				}
				catch (e:Exception)
					new Error('Failed to create output file: $e', true);

			if (FileSystem.exists("./logs"))
				Sys.println("Logs directory 'logs' already exists.");
			else
			{
				try
				{
					Sys.command("mkdir", ["logs"]);
					Sys.println("Created directory 'logs'.");
				}
				catch (e:Exception)
					new Error('Failed to create logs directory: $e', true);
			}

			new Success("Everything is as it should be.");
		}
		else if (args[0] == "del-logs")
		{
			final logFiles:Array<String> = FileSystem.readDirectory("./logs");

			if (logFiles.length < 1)
				new Success("No log files to delete.");

			try
			{
				for (log in logFiles)
					Sys.command('cd ./logs && rm $log');
				new Success('Successfully deleted ${logFiles.length} log file(s).');
			}
			catch (e:Exception)
				new Error('Failed to delete all log files: $e', true);
		}
		else if (args[0] == "wipe")
		{
			if (Sys.args().length > 1)
				new Error("Too many arguments given for wipe command.");

			if (File.getContent("./bin/PW.bin").length < 1)
				new Success("No data to erase.");

			try
			{
				File.saveContent("./bin/PW.bin", "");
				new Success("Successfully erased all data!");
			}
			catch (e:Exception)
				new Error('Failed to erase all data: $e', true);
		}
		else
			new Error('Unknown command: "${args[0]}"');

		return argsMap;
	}
}
