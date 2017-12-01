import cpp.Lib;
import sys.io.File;

/**
 * ...
 * @author Martin Jonasson (m@grapefrukt.com)
 */
class Day01 {
	
	static function main() {
		day1();
		day1plus();
	}
	
	static function day1() {
		var input = File.read('day1.txt');
		var value = -1, first = -1, previous = -1;
		var sum = 0;
		
		while (true) {
			var char = '';
			try {
				char = input.readString(1);
			} catch (ex:haxe.io.Eof){
				break;
			}
			
			previous = value;
			
			value = Std.parseInt(char);
			if (first == -1) first = value;
			if (value == previous) sum += value;
		}
		
		if (value == first) sum += value;
		
		Sys.print('Day 1:\t$sum\n');
	}
	
	static function day1plus() {
		var input = File.read('day1.txt');
		
		var values = [];
		while (true) {
			try {
				var char = input.readString(1);
				var value = Std.parseInt(char);
				values.push(value);
			} catch (ex:haxe.io.Eof){
				break;
			}
		}
		
		var sum = 0;
		var offset = Std.int(values.length / 2);
		for (i in 0 ... values.length) {
			if (values[i] == values[(i + offset) % values.length]) sum += values[i];
		}
		
		Sys.print('Day 1+:\t$sum\n');
	}
	
}