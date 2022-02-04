package;

import Error;
import Lpm;
import Success;
import haxe.Exception;
import haxe.crypto.Base64;
import haxe.io.Bytes;
import sys.io.File;

final class Converter
{
	private static final seperator:String = "%";

	public static inline function setData(parent:String, email:String, username:String, password:String, silent:Bool = false)
	{
		final parentEncoded:String = encodeData(parent);
		final emailEncoded:Null<String> = email != null ? encodeData(email) : null;
		final usernameEncoded:Null<String> = username != null ? encodeData(username) : null;
		final passwordEncoded:String = encodeData(password);

		final dataArray:Array<String> = [];

		dataArray.push(parentEncoded);
		dataArray.push(emailEncoded);
		dataArray.push(usernameEncoded);
		dataArray.push(passwordEncoded);

		final contents:String = File.getContent('/home/${Lpm.username}/.lpm/lpm.bin');

		try
		{
			if (contents.length < 1)
				File.saveContent('/home/${Lpm.username}/.lpm/lpm.bin', '${dataArray.join('$seperator');}\n');
			else
				File.saveContent('/home/${Lpm.username}/.lpm/lpm.bin', '$contents${dataArray.join('$seperator');}\n');

			if (!silent)
				new Success("Successfully saved data!");
		}
		catch (e:Exception)
			new Error('Failed to write to lpm.bin: $e', true);
	}

	public static function getData(parent:String, noFormat:Bool = false):String
	{
		var data:String = "";

		final contents:String = File.getContent('/home/${Lpm.username}/.lpm/lpm.bin');
		final lfSplit:Array<String> = contents.split("\n");

		for (l in lfSplit)
		{
			final seperatorSplit:Array<String> = l.split(seperator);

			if (seperatorSplit[0] == "")
				new Error('"$parent" was not found.');

			if (decodeData(seperatorSplit[0]) == parent)
			{
				!noFormat ? data += '<b,gray>App / Website:<//> <yellow>"${decodeData(seperatorSplit[0])}"</>\n' : data += '${decodeData(seperatorSplit[0])}->';

				!noFormat ? data += '<b,gray>Email:<//> <yellow>"${decodeData(seperatorSplit[1])}"</>\n' : data += '${decodeData(seperatorSplit[1])}->';

				!noFormat ? data += '<b,gray>Username:<//> <yellow>"${decodeData(seperatorSplit[2])}"</>\n' : data += '${decodeData(seperatorSplit[2])}->';

				!noFormat ? data += '<b,gray>Password:<//> <yellow>"${decodeData(seperatorSplit[3])}"</>' : data += '${decodeData(seperatorSplit[3])}';

				break;
			}
			else
				continue;
		}

		return data;
	}

	public static inline function deleteData(parent:String, silent:Bool = false):Void
	{
		var dataToRemove:String = "";

		final contents:String = File.getContent('/home/${Lpm.username}/.lpm/lpm.bin');
		final lfSplit:Array<String> = contents.split("\n");

		for (l in lfSplit)
		{
			final seperatorSplit:Array<String> = l.split(seperator);

			if (seperatorSplit[0] == "")
				new Error('"$parent" was not found.');

			if (decodeData(seperatorSplit[0]) == parent)
			{
				dataToRemove += l;
				break;
			}
			else
				continue;
		}

		final newLines:Array<String> = [];

		for (l in lfSplit)
			if (l != dataToRemove)
				newLines.push(l);
			else
				continue;

		try
		{
			File.saveContent('/home/${Lpm.username}/.lpm/lpm.bin', newLines.join("\n"));
			if (!silent)
				new Success('Successfully removed "$parent" and all it\'s data!');
		}
		catch (e:Exception)
			new Error('Failed to save new content to lpm.bin: $e', true);
	}

	public static function checkExistanceOfData(parent:String):Bool
	{
		var exists:Bool = false;

		final contents:String = File.getContent('/home/${Lpm.username}/.lpm/lpm.bin');
		final lfSplit:Array<String> = contents.split("\n");

		for (l in lfSplit)
		{
			final seperatorSplit:Array<String> = l.split(seperator);

			if (seperatorSplit[0] == "")
			{
				exists = false;
				break;
			}
			else if (decodeData(seperatorSplit[0]) == parent)
			{
				exists = true;
				break;
			}
			else
				continue;
		}

		return exists;
	}

	public static inline function getPieceOfData(parent:String):Null<String>
	{
		var piece:Null<String> = "";

		final contents:String = File.getContent('/home/${Lpm.username}/.lpm/lpm.bin');
		final lfSplit:Array<String> = contents.split("\n");

		for (l in lfSplit)
		{
			final seperatorSplit:Array<String> = l.split(seperator);

			if (seperatorSplit[0] == "")
				break;

			if (decodeData(seperatorSplit[0]) == parent)
			{
				piece += l;
				break;
			}
			else
				continue;
		}

		return piece != "" ? piece : null;
	}

	public static inline function encodeData(data:String):String
	{
		return parseStringToBinary(Base64.encode(Bytes.ofString(data, null), true));
	}

	public static inline function decodeData(data:String):String
	{
		return Base64.decode(parseFromString(data), true).toString();
	}

	private static inline function parseStringToBinary(string:String):String
	{
		var charSplit = string.split("");
		var encode:Array<String> = [];

		for (char in charSplit)
		{
			switch (char)
			{
				case "A":
					encode.push("01000001");
				case "B":
					encode.push("01000010");
				case "C":
					encode.push("01000011");
				case "D":
					encode.push("01000100");
				case "E":
					encode.push("01000101");
				case "F":
					encode.push("01000110");
				case "G":
					encode.push("01000111");
				case "H":
					encode.push("01001000");
				case "I":
					encode.push("01001001");
				case "J":
					encode.push("01001010");
				case "K":
					encode.push("01001011");
				case "L":
					encode.push("01001100");
				case "M":
					encode.push("01001101");
				case "N":
					encode.push("01001110");
				case "O":
					encode.push("01001111");
				case "P":
					encode.push("01010000");
				case "Q":
					encode.push("01010001");
				case "R":
					encode.push("01010010");
				case "S":
					encode.push("01010011");
				case "T":
					encode.push("01010100");
				case "U":
					encode.push("01010101");
				case "V":
					encode.push("01010110");
				case "W":
					encode.push("01010111");
				case "X":
					encode.push("01011000");
				case "Y":
					encode.push("01011001");
				case "Z":
					encode.push("01011010");
				case "a":
					encode.push("01100001");
				case "b":
					encode.push("01100010");
				case "c":
					encode.push("01100011");
				case "d":
					encode.push("01100100");
				case "e":
					encode.push("01100101");
				case "f":
					encode.push("01100110");
				case "g":
					encode.push("01100111");
				case "h":
					encode.push("01101000");
				case "i":
					encode.push("01101001");
				case "j":
					encode.push("01101010");
				case "k":
					encode.push("01101011");
				case "l":
					encode.push("01101100");
				case "m":
					encode.push("01101101");
				case "n":
					encode.push("01101110");
				case "o":
					encode.push("01101111");
				case "p":
					encode.push("01110000");
				case "q":
					encode.push("01110001");
				case "r":
					encode.push("01110010");
				case "s":
					encode.push("01110011");
				case "t":
					encode.push("01110100");
				case "u":
					encode.push("01110101");
				case "v":
					encode.push("01110110");
				case "w":
					encode.push("01110111");
				case "x":
					encode.push("01111000");
				case "y":
					encode.push("01111001");
				case "z":
					encode.push("01111010");
				case "0":
					encode.push("00110000");
				case "1":
					encode.push("00110001");
				case "2":
					encode.push("00110010");
				case "3":
					encode.push("00110011");
				case "4":
					encode.push("00110100");
				case "5":
					encode.push("00110101");
				case "6":
					encode.push("00110110");
				case "7":
					encode.push("00110111");
				case "8":
					encode.push("00111000");
				case "9":
					encode.push("00111001");
				case "`":
					encode.push("01100000");
				case "~":
					encode.push("01111110");
				case "!":
					encode.push("00100001");
				case "@":
					encode.push("01000000");
				case "#":
					encode.push("00100011");
				case "$":
					encode.push("00100100");
				case "%":
					encode.push("00100101");
				case "^":
					encode.push("01011110");
				case "&":
					encode.push("00100110");
				case "*":
					encode.push("00101010");
				case "(":
					encode.push("00101000");
				case ")":
					encode.push("00101001");
				case "-":
					encode.push("00101101");
				case "_":
					encode.push("01011111");
				case "=":
					encode.push("00111101");
				case "+":
					encode.push("00101011");
				case "[":
					encode.push("01011011");
				case "{":
					encode.push("01111011");
				case "]":
					encode.push("01011101");
				case "}":
					encode.push("01111101");
				case "\\":
					encode.push("01011100");
				case "|":
					encode.push("01111100");
				case ";":
					encode.push("00111011");
				case ":":
					encode.push("00111010");
				case "'":
					encode.push("00100111");
				case "\"":
					encode.push("00100010");
				case ",":
					encode.push("00101100");
				case "<":
					encode.push("00111100");
				case ".":
					encode.push("00101110");
				case ">":
					encode.push("00111110");
				case "/":
					encode.push("00101111");
				case "?":
					encode.push("00111111");
				case " ":
					encode.push("00100000");
				case "\n":
					encode.push("00001010");
				default:
					new Error('Unknown character: "$char"', true);
			}
		}

		return encode.join(" ");
	}

	private static inline function parseFromString(string:String):String
	{
		var byteSplit = string.split(" ");

		var decode:Array<String> = [];

		for (byte in byteSplit)
		{
			switch (byte)
			{
				case "01000001":
					decode.push("A");
				case "01000010":
					decode.push("B");
				case "01000011":
					decode.push("C");
				case "01000100":
					decode.push("D");
				case "01000101":
					decode.push("E");
				case "01000110":
					decode.push("F");
				case "01000111":
					decode.push("G");
				case "01001000":
					decode.push("H");
				case "01001001":
					decode.push("I");
				case "01001010":
					decode.push("J");
				case "01001011":
					decode.push("K");
				case "01001100":
					decode.push("L");
				case "01001101":
					decode.push("M");
				case "01001110":
					decode.push("N");
				case "01001111":
					decode.push("O");
				case "01010000":
					decode.push("P");
				case "01010001":
					decode.push("Q");
				case "01010010":
					decode.push("R");
				case "01010011":
					decode.push("S");
				case "01010100":
					decode.push("T");
				case "01010101":
					decode.push("U");
				case "01010110":
					decode.push("V");
				case "01010111":
					decode.push("W");
				case "01011000":
					decode.push("X");
				case "01011001":
					decode.push("Y");
				case "01011010":
					decode.push("Z");
				case "01100001":
					decode.push("a");
				case "01100010":
					decode.push("b");
				case "01100011":
					decode.push("c");
				case "01100100":
					decode.push("d");
				case "01100101":
					decode.push("e");
				case "01100110":
					decode.push("f");
				case "01100111":
					decode.push("g");
				case "01101000":
					decode.push("h");
				case "01101001":
					decode.push("i");
				case "01101010":
					decode.push("j");
				case "01101011":
					decode.push("k");
				case "01101100":
					decode.push("l");
				case "01101101":
					decode.push("m");
				case "01101110":
					decode.push("n");
				case "01101111":
					decode.push("o");
				case "01110000":
					decode.push("p");
				case "01110001":
					decode.push("q");
				case "01110010":
					decode.push("r");
				case "01110011":
					decode.push("s");
				case "01110100":
					decode.push("t");
				case "01110101":
					decode.push("u");
				case "01110110":
					decode.push("v");
				case "01110111":
					decode.push("w");
				case "01111000":
					decode.push("x");
				case "01111001":
					decode.push("y");
				case "01111010":
					decode.push("z");
				case "00110000":
					decode.push("0");
				case "00110001":
					decode.push("1");
				case "00110010":
					decode.push("2");
				case "00110011":
					decode.push("3");
				case "00110100":
					decode.push("4");
				case "00110101":
					decode.push("5");
				case "00110110":
					decode.push("6");
				case "00110111":
					decode.push("7");
				case "00111000":
					decode.push("8");
				case "00111001":
					decode.push("9");
				case "01100000":
					decode.push("`");
				case "01111110":
					decode.push("~");
				case "00100001":
					decode.push("!");
				case "01000000":
					decode.push("@");
				case "00100011":
					decode.push("#");
				case "00100100":
					decode.push("$");
				case "00100101":
					decode.push("%");
				case "01011110":
					decode.push("^");
				case "00100110":
					decode.push("&");
				case "00101010":
					decode.push("*");
				case "00101000":
					decode.push("(");
				case "00101001":
					decode.push(")");
				case "00101101":
					decode.push("-");
				case "01011111":
					decode.push("_");
				case "00111101":
					decode.push("=");
				case "00101011":
					decode.push("+");
				case "01011011":
					decode.push("[");
				case "01111011":
					decode.push("{");
				case "01011101":
					decode.push("]");
				case "01111101":
					decode.push("}");
				case "01011100":
					decode.push("\\");
				case "01111100":
					decode.push("|");
				case "00111011":
					decode.push(";");
				case "00111010":
					decode.push(":");
				case "00100111":
					decode.push("'");
				case "00100010":
					decode.push("\"");
				case "00101100":
					decode.push(",");
				case "00111100":
					decode.push("<");
				case "00101110":
					decode.push(".");
				case "00111110":
					decode.push(">");
				case "00101111":
					decode.push("/");
				case "00111111":
					decode.push("?");
				case "00100000":
					decode.push(" ");
				case "00001010":
					decode.push("\n");
				default:
					new Error('Unknown byte: "$byte"', true);
			}
		}

		return decode.join("");
	}
}
