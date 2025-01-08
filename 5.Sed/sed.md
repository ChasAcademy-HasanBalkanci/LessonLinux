# SED Exercises

## Question 1: Listing .sh Files in Scripts Directory

**Question:** Print a list of files in your scripts directory, ending in ".sh". Mind that you might have to unalias ls. Put the result in a temporary file.

**Solution:**

```bash
\ls -1 ~/scripts | sed -n '/\.sh$/p' > /tmp/sh_scripts.txt
```

# Explanation:
1. \ls: Uses the actual ls command, bypassing any alias.
2. -1: Forces ls to output one file per line.
3. ~/scripts: Path to your scripts directory. Adjust if needed.
4.|: Pipes the output of ls to sed.
5. sed -n '/\.sh$/p': 
-n: Suppresses automatic printing of pattern space.
/\.sh$/p: The sed pattern and command:
\.sh$: Matches ".sh" at the end of a line.
p: Prints the lines that match the pattern.
6. > /tmp/sh_scripts.txt: Redirects the output to a temporary file.



**Question2:** Make a list of files in /usr/bin that have the letter "a" as the second character. Put the result in a temporary file.

**Solution:**

```bash
ls -1 /usr/bin | sed -n '/^.a/p' > /tmp/a_second_char.txt
```

# Explanation:
1. ls -1 /usr/bin: Lists the contents of /usr/bin directory, one file per line.
2. |: Pipes the output of ls to sed.
3. sed -n '/^.a/p': 
-n: Suppresses automatic printing of pattern space.
/^.a/p: The sed pattern and command:
^: Matches the start of the line.
.: Matches any single character.
a: Matches the letter 'a'.
p: Prints the lines that match the pattern.
4. > /tmp/a_second_char.txt: Redirects the output to a temporary file.

**Question3:** Delete the first 3 lines of each temporary file.

**Solution:**

To delete the first 3 lines of each temporary file, we'll use `sed` with the `-i` option to edit the files in-place. Here are the commands:

```bash
sed -i '1,3d' /tmp/sh_scripts.txt
sed -i '1,3d' /tmp/a_second_char.txt
```

# Explanation:
1. sed: The stream editor command.
2. -i: This option allows sed to edit the file in-place, saving changes directly to the file.
3. '1,3d': This is the sed command:
1,3: Specifies the range of lines (from line 1 to line 3).
d: The delete command, which removes the specified lines.
4. /tmp/sh_scripts.txt and /tmp/a_second_char.txt: The files to be edited.


**Question4:** Print to standard output only the lines containing the pattern "an".

**Solution:**

To print only the lines containing the pattern "an" from both temporary files, we can use `sed` with the `-n` option and the `p` command. Here's the command:

```bash
sed -n '/an/p' /tmp/sh_scripts.txt /tmp/a_second_char.txt
```

# Explanation:
1. sed: The stream editor command.
2. -n: Suppresses automatic printing of pattern space.
3. '/an/p': This is the sed command:
/an/: Specifies the pattern to search for (in this case, "an").
p: The print command, which outputs the lines matching the pattern.
4. /tmp/sh_scripts.txt and /tmp/a_second_char.txt: The files to be processed.
This command will print to standard output all lines from both files that contain the pattern "an".

**Qest5**
Create a file holding sed commands to perform the previous two tasks. Add an extra command to this
file that adds a string like "*** This might have something to do with man and man pages ***" in the
line preceding every occurence of the string "man". Check the results.

```bash
sed -n -f /tmp/sed_script.sed /tmp/sh_scripts.txt /tmp/a_second_char.txt > /tmp/processed_output.txt
```

# Explanation:
1. The sed script file (/tmp/sed_script.sed) contains three commands:
1,3d: Deletes the first 3 lines of each file.
/an/p: Prints lines containing "an".
/man/i\...: Inserts the specified text before lines containing "man".
2. sed -n -f /tmp/sed_script.sed ...: 
-n: Suppresses automatic printing of pattern space.
-f /tmp/sed_script.sed: Specifies the script file to use.
3. /tmp/sh_scripts.txt /tmp/a_second_char.txt: The input files to process.
4. > /tmp/processed_output.txt: Redirects the output to a new file.



**Question6:** A long listing of the root directory, /, is used for input. Create a file holding sed commands that check for symbolic links and plain files. If a file is a symbolic link, precede it with a line like "--This is a symlink--". If the file is a plain file, add a string on the same line, adding a comment like "<--- this is a plain file".

**Solution:**

**Question6:** A long listing of the root directory, /, is used for input. Create a file holding sed commands that check for symbolic links and plain files. If a file is a symbolic link, precede it with a line like "--This is a symlink--". If the file is a plain file, add a string on the same line, adding a comment like "<--- this is a plain file".

**Solution:**

create the sed script file:
Heredoc syntax: 
```bash
cat << 'EOF' > /tmp/root_file_types.sed
# Check for symbolic links (first character is 'l')
/^l/ i\--This is a symlink--

# Check for plain files (first character is '-')
/^-/ s/$/ <--- this is a plain file/
EOF


```bash
ls -l / | sed -f /tmp/root_file_types.sed > /tmp/root_file_types_output.txt
```

## Explanation:
1. The sed script file (/tmp/root_file_types.sed) contains two commands:
/^l/ i\--This is a symlink--: 
/^l/ matches lines starting with 'l' (symbolic links in ls -l output)
i\ inserts the specified text before the matching line
/^-/ s/$/ <--- this is a plain file/:
/^-/ matches lines starting with '-' (regular files in ls -l output)
s/$/ <--- this is a plain file/ appends the specified text at the end of the matching line
2. ls -l /: Generates a long listing of the root directory
3. sed -f /tmp/root_file_types.sed: Applies the sed script to the ls output. f script-file,--file=script-file
add the contents of script-file to the commands to be executed.
4. > /tmp/root_file_types_output.txt: Redirects the processed output to a file