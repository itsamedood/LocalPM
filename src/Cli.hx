package;

import Lpm;
import haxe.Exception;
import sys.FileSystem;
import sys.io.File;

using StringTools;

final class Cli
{
	public static function getArgs():Void
	{
		var passwordSet:Bool = false;
		var parentSet:Bool = false;
		var emailSet:Bool = false;
		var usernameSet:Bool = false;

		final args:Array<String> = Sys.args();
		final argsMap:Map<String, Any> = new Map<String, String>();

		args[0] == null ? new Error("No command given. Run 'pm help' for a list of all commands.") : {
			switch (args[0])
			{
				case "help":
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
							Sys.println("Sets up the password Lpm to work. This can also be used for troubleshooting.");
							Sys.println("No arguments.");
						case "del-logs":
							Sys.println("Deletes all logs (if any.)");
							Sys.println("No arguments.");
						case "wnew Error('$parent not found.');ipe":
							Sys.println("Erases ALL data-sets. This is irreversible.");
							Sys.println("No arguments.");
						case "help":
							Sys.println("Displays a list of all commands or a description with arguments for a specific command.");
							Sys.println("ARGUMENTS");
							Sys.println("=========");
							Sys.println("[command]");
						case "version":
							Sys.println("Displays the current version installed.");
							Sys.println("No arguments.");
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
							Sys.println("version");
							Sys.println("help");
							Sys.println("========");
							Sys.println("You can also do: pm help <command>");
					}
				case "set":
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

					!Converter.checkExistanceOfData(argsMap.get("PR")) ? Converter.setData(argsMap.get("PR"), argsMap.get("EA"), argsMap.get("UN"),
						argsMap.get("PW")) : new Error("That parent already exists. Use the 'edit' command if you are trying to modify it.");

				case "get":
					if (Sys.args()
						.length < 2) new Error("Missing argument 'parent'"); else if (Sys.args()
						.length > 2) new Error("Too many arguments given for get command."); else if (File.getContent('/home/${Lpm.username}/.lpm/lpm.bin')
						.length < 1) new Success("No passwords to get."); else
					{
						Console.logPrefix = "";
						Console.log(Converter.getData(Sys.args()[1]));
						Sys.exit(0);
					}

				case "edit":
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
				case "delete":
					if (Sys.args()
						.length < 2) new Error("Missing argument 'parent'"); else if (Sys.args()
						.length > 2) new Error("Too many arguments given for delete command."); else if (File.getContent('/home/${Lpm.username}/.lpm/lpm.bin')
						.length < 1) new Success("No passwords to delete."); else Converter.deleteData(Sys.args()[1]);

				case "list":
					if (Sys.args().length > 1)
						new Error("Too many arguments given for list command.");

					final contents:String = File.getContent('/home/${Lpm.username}/.lpm/lpm.bin');

					if (contents.length < 1)
						new Success("No passwords have been added... yet!");

					final lfSplit:Array<String> = contents.split("\n");

					for (line in lfSplit)
						line != "" ? {
							Console.logPrefix = "<b,gray>•<//> ";
							Console.log('<yellow>${Converter.decodeData(line.split("%")[0])}</>');
						} : break;

				case "setup":
					if (Sys.systemName() == "Linux")
					{
						if (FileSystem.exists('/home/${Lpm.username}/.lpm'))
							Sys.println("Directory '.lpm' already exists.");
						else
						{
							Sys.command("cd ~/ && mkdir .lpm");
							Sys.println("Directory '.lpm' created.");
						}

						if (FileSystem.exists('/home/${Lpm.username}/.lpm/lpm.bin'))
							Sys.println("File 'lpm.bin' already exists");
						else
						{
							Sys.command("cd ~/.lpm && touch lpm.bin");
							Sys.println("File 'lpm.bin' created.");
						}

						if (FileSystem.exists('/home/${Lpm.username}/.lpm/logs'))
							Sys.println("Directory 'logs' already exists");
						else
						{
							Sys.command("cd ~/.lpm && mkdir logs");
							Sys.println("Directory 'logs' created.");
						}
					}

				case "wipe":
					if (Sys.args().length > 1)
						new Error("Too many arguments given for wipe command.");

					if (File.getContent('/home/${Lpm.username}/.lpm/lpm.bin').length < 1)
						new Success("No data to erase.");

					try
					{
						File.saveContent('/home/${Lpm.username}/.lpm/lpm.bin', "");
						new Success("Successfully erased all data!");
					}
					catch (e:Exception) new Error('Failed to erase all data: $e', true);

				case "version":
					Sys.args().length > 1 ? new Error("Too many arguments given for version command.") : Console.log(Lpm.VERSION);
				default:
					new Error('Unknown command: "${args[0]}"');
			}
		}
	}
}
