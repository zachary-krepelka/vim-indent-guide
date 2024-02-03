<!--
	FILENAME: README.md
	AUTHOR: Zachary Krepelka
	DATE: Thursday, February 1st, 2024
	ORIGIN: https://github.com/zachary-krepelka/vim-indent-guide.git
	DESCRIPTION: An indentation guide for the Vim text editor
	UPDATED: Saturday, February 3rd, 2024 at 4:04 PM
-->

# indent-guide.vim

This plugin provides an indentation guide for the Vim text editor.  A series
of evenly-spaced bars are drawn across the screen.  Each bar is separated from
the last by one tabstop.  This continues until the textwidth is reached.

The user can dynamically adjust the tabstop and textwidth using the arrow
keys with the help of a visual aid.  Facilities are also provided for altering
the indentation of a file, i.e., changing spaces to tabs and vice versa.

Use your favorite plugin manager for installation.

## Example

```text
	BEFORE

			+---------------------------------------+
			|class Integer                          |
			|    def totatives                      |
			|        fail unless positive?          |
			|        1.upto(self).select do |i|     |
			|            gcd(i) == 1                |
			|        end                            |
			|    end                                |
			|end                                    |
			|~                                      |
			|-- INSERT --                           |
			+---------------------------------------+

	AFTER

			+---------------------------------------+
			|cla|s I|teg|r  |   |   |   |   |   |   |
			|   |def|tot|tiv|s  |   |   |   |   |   |
			|   |   |fai| un|ess|pos|tiv|?  |   |   |
			|   |   |1.u|to(|elf|.se|ect|do |i| |   |
			|   |   |   |gcd|i) |= 1|   |   |   |   |
			|   |   |end|   |   |   |   |   |   |   |
			|   |end|   |   |   |   |   |   |   |   |
			|end|   |   |   |   |   |   |   |   |   |
			|~                                      |
			|-- INSERT --                           |
			+---------------------------------------+
```
