# control operator:  newline or 
# ‘||’, ‘&&’, ‘&’, ‘;’, ‘;;’, ‘;&’, ‘;;&’, ‘|’, ‘|&’, ‘(’, or ‘)’.
sbhi command  caller  ko exit status
value return krTi h. zo 8bit hoTi h. isliy return valu maksimum 255 hoTi h.

field

A unit of text that is the result of one of the shell expansions. After expansion,
when executing a command, the resulting fields are used as the command name
and arguments.

filename A string of characters used to identify a file.

job
A set of processes comprising a pipeline, and any processes descended from it,
that are all in the same process group.
job control
A mechanism by which users can selectively stop (suspend) and restart (resume)
execution of processes.

metacharacter
A character that, when unquoted, separates words. A metacharacter is a space,
tab, newline, or one of the following characters: , , , , , , or .


process group
A collection of related processes each having the same process group id.

process group ID
A simple shell command such as echo a b c consists of the command itself followed by
arguments, separated by spaces.

More complex shell commands are composed of simple commands arranged together in
a variety of ways: in a pipeline in which the output of one command becomes the input of
a second, in a loop or conditional construct, or in some other grouping.

3.2.1 Reserved Words
Reserved words are words that have special meaning to the shell. They are used to begin
and end the shells just a sequence of
words separated by blanks, terminated by one of the shells arguments.

The return status (see Section 3.7.5 [Exit Status], page 44) of a simple command is its
exit status as provided by the posix 1003.1 waitpid function, or 128+n if the command
was terminated by signal n.

Chapter 3: Basic Shell Features

10

3.2.3 Pipelines
A pipeline is a sequence of one or more commands separated by one of the control operators
or .

The format for a pipeline is

[time [-p]] [!] command1 [ | or |& command2 ] ...

The output of each command in the pipeline is connected via a pipe to the input of the next
command. That is, each command reads the previous command|&s standard error, in addition to its standard output, is con-
nected to command2s execution. The -p option changes the output format to
that specified by posix. When the shell is in posix mode (see Section 6.11 [Bash POSIX
Mode], page 106), it does not recognize time as a reserved word if the next token begins
with a . The TIMEFORMAT variable may be set to a format string that specifies how the
timing information should be displayed. See Section 5.2 [Bash Variables], page 78, for a
description of the available formats. The use of time as a reserved word permits the timing
of shell builtins, shell functions, and pipelines. An external time command cannot time
these easily.

When the shell is in posix mode (see Section 6.11 [Bash POSIX Mode], page 106), time
may be followed by a newline. In this case, the shell displays the total user and system time
consumed by the shell and its children. The TIMEFORMAT variable may be used to specify
the format of the time information.

If the pipeline is not executed asynchronously (see Section 3.2.4 [Lists], page 10), the

shell waits for all commands in the pipeline to complete.


3.2.5.1 Looping Constructs
echo -n "Enter the name of an animal: "
read ANIMAL
echo -n "The $ANIMAL has "
case $ANIMAL in

horse | dog | cat) echo -n "four";;
man | kangaroo ) echo -n "two";;
*) echo -n "an unknown number of";;

esac
echo " legs."

select name [in words ...]; do commands; done
select

select fname in *;
do
echo you picked $fname \($REPLY\)
break;
done

(( expression ))
[[ expression ]]
[[ . =~ [.] ]]

The shell performs any word expansions before passing the pattern to the reg-
ular expression functions, so you can assume that the shells necessary.
The array variable BASH_REMATCH records which parts of the string matched
the pattern. The element of BASH_REMATCH with index 0 contains the portion
of the string matching the entire regular expression. Substrings matched by
parenthesized subexpressions within the regular expression are saved in the
remaining BASH_REMATCH indices. The element of BASH_REMATCH with index n
is the portion of the string matching the nth parenthesized subexpression.
Bash sets BASH_REMATCH in the global scope; declaring it as a local variable will
lead to unexpected results.
Expressions may be combined using the following operators, listed in decreasing
order of precedence:

( expression )
! expression
expression1 && expression2
expression1 || expression2

3.2.5.3 Grouping Commands
( list )
{ list; }

3.2.6 Coprocesses
coproc [NAME] command [redirections]

This creates a coprocess named NAME. command may be either a simple command (see
Section 3.2.2 [Simple Commands], page 9) or a compound command (see Section 3.2.5
If NAME is not
[Compound Commands], page 11). NAME is a shell variable name.
supplied, the default name is COPROC.

The recommended form to use for a coprocess is

coproc NAME { command; }

This form is recommended because simple commands result in the coprocess always being
named COPROC, and it is simpler to use and more complete than the other compound
commands.

There are other forms of coprocesses:
coproc NAME compound-command
coproc compound-command
coproc simple-command

If command is a compound command, NAME is optional. The word following coproc
determines whether that word is interpreted as a variable name: it is interpreted as NAME
if it is not a reserved word that introduces a compound command. If command is a simple
command, NAME is not allowed; this is to avoid confusion between NAME and the first
word of the simple command.

When the coprocess is executed, the shell creates an array variable (see Section 6.7
[Arrays], page 100) named NAME in the context of the executing shell. The standard
output of command is connected via a pipe to a file descriptor in the executing shell, and
that file descriptor is assigned to NAME[0]. The standard input of command is connected
via a pipe to a file descriptor in the executing shell, and that file descriptor is assigned
to NAME[1]. This pipe is established before any redirections specified by the command
(see Section 3.6 [Redirections], page 38). The file descriptors can be utilized as arguments
to shell commands and redirections using standard word expansions. Other than those
created to execute command and process substitutions, the file descriptors are not available
in subshells.

The process ID of the shell spawned to execute the coprocess is available as the value of
the variable NAME_PID. The wait builtin command may be used to wait for the coprocess
to terminate.

Chapter 3: Basic Shell Features

Since the coprocess is created as an asynchronous command, the coproc command always
returns success. The return status of a coprocess is the exit status of command.

3.2.7 GNU Parallel
There are ways to run commands in parallel that are not built into Bash. GNU Parallel is
a tool to do just that.

GNU Parallel, as its name suggests, can be used to build and run commands in parallel.
You may run the same command with different arguments, whether they are filenames,
usernames, hostnames, or lines read from files. GNU Parallel provides shorthand references
to many of the most common operations (input lines, various portions of the input line,
different ways to specify the input source, and so on). Parallel can replace xargs or feed
commands from its input sources to several different instances of Bash.

For a complete description, refer to the GNU Parallel documentation, which is available

at https://www.gnu.org/software/parallel/parallel_tutorial.html.

3.3 Shell Functions

Shell functions are a way to group commands for later execution using a single name for
the group. They are executed just like a "regular" command. When the name of a shell
function is used as a simple command name, the list of commands associated with that
function name is executed. Shell functions are executed in the current shell context; no new
process is created to interpret them.

Functions are declared using this syntax:

fname () compound-command [ redirections ]

or

function fname [()] compound-command [ redirections ]

This defines a shell function named fname. The reserved word function is optional.
If the function reserved word is supplied, the parentheses are optional. The body of the
function is the compound command compound-command (see Section 3.2.5 [Compound
Commands], page 11). That command is usually a list enclosed between { and }, but may
be any compound command listed above. If the function reserved word is used, but the
parentheses are not supplied, the braces are recommended. compound-command is executed
whenever fname is specified as the name of a simple command. When the shell is in posix
mode (see Section 6.11 [Bash POSIX Mode], page 106), fname must be a valid shell name
and may not be the same as one of the special builtins (see Section 4.4 [Special Builtins],
page 77). In default mode, a function name can be any unquoted shell word that does not
contain . Any redirections (see Section 3.6 [Redirections], page 38) associated with the
shell function are performed when the function is executed. A function definition may be
deleted using the -f option to the unset builtin (see Section 4.1 [Bourne Shell Builtins],
page 48).

The exit status of a function definition is zero unless a syntax error occurs or a readonly
function with the same name already exists. When executed, the exit status of a function
is the exit status of the last command executed in the body.

Note that for historical reasons, in the most common usage the curly braces that surround
the body of the function must be separated from the body by blanks or newlines. This
is because the braces are reserved words and are only recognized as such when they are
separated from the command list by whitespace or another shell metacharacter. Also, when
using the braces, the list must be terminated by a semicolon, a , or a newline.

When a function is executed, the arguments to the function become the positional pa-
rameters during its execution (see Section 3.4.1 [Positional Parameters], page 23). The
special parameter  that expands to the number of positional parameters is updated to
reflect the change. Special parameter 0 is unchanged. The first element of the FUNCNAME
variable is set to the name of the function while the function is executing.

All other aspects of the shell execution environment are identical between a function and
its caller with these exceptions: the DEBUG and RETURN traps are not inherited unless the
function has been given the trace attribute using the declare builtin or the -o functrace
option has been enabled with the set builtin, (in which case all functions inherit the DEBUG
and RETURN traps), and the ERR trap is not inherited unless the -o errtrace shell option
has been enabled. See Section 4.1 [Bourne Shell Builtins], page 48, for the description of
the trap builtin.

The FUNCNEST variable, if set to a numeric value greater than 0, defines a maximum
function nesting level. Function invocations that exceed the limit cause the entire command
to abort.

If the builtin command return is executed in a function, the function completes and
execution resumes with the next command after the function call. Any command associated
with the RETURN trap is executed before execution resumes. When a function completes,
the values of the positional parameters and the special parameter  are restored to the
values they had prior to the functions return status; otherwise the functions caller and so on, back to the "global" scope, where
the shell is not executing any shell function. Consequently, a local variable at the current
local scope is a variable declared using the local or declare builtins in the function that
is currently executing.

Local variables "shadow" variables with the same name declared at previous scopes.
For instance, a local variable declared in a function hides a global variable of the same
name: references and assignments refer to the local variable, leaving the global variable
unmodified. When the function returns, the global variable is once again visible.

The shell uses dynamic scoping to control a variablefunc1 local+=s previous value. This includes arguments to builtin commands
such as declare that accept assignment statements (declaration commands). When  is
applied to a variable for which the integer attribute has been set, value is evaluated as
an arithmetic expression and added to the variable+=s value is not unset (as it is when using ), and new
values are appended to the array beginning at one greater than the arrays value.

A variable can be assigned the nameref attribute using the -n option to the declare or
local builtin commands (see Section 4.2 [Bash Builtins], page 55) to create a nameref, or a
reference to another variable. This allows variables to be manipulated indirectly. Whenever
the nameref variable is referenced, assigned to, unset, or has its attributes modified (other
than using or changing the nameref attribute itself), the operation is actually performed on
the variable specified by the nameref variables arguments when it is invoked,
and may be reassigned using the set builtin command. Positional parameter N may be
referenced as ${N}, or as $N when N consists of a single digit. Positional parameters may
not be assigned to with assignment statements. The set and shift builtins are used to
set and unset them (see Chapter 4 [Shell Builtin Commands], page 48). The positional
parameters are temporarily replaced when a shell function is executed (see Section 3.3
[Shell Functions], page 19).

When a positional parameter consisting of more than a single digit is expanded, it must

be enclosed in braces.

3.4.2 Special Parameters
($*) Expands to the positional parameters, starting from one. When the ex-
($@) Expands to the positional parameters, starting from one.
($#) Expands to the number of positional parameters in decimal.
($?) Expands to the exit status of the most recently executed foreground
($-, a hyphen.) Expands to the current option flags as specified upon invocation,
($$) Expands to the process id of the shell. In a subshell, it expands to the
($!) Expands to the process id of the job most recently placed into the back-
($0) Expands to the name of the shell or shell script. This is set at shell
initialization. If Bash is invoked with a file of commands (see Section 3.8 [Shell
Scripts], page 46), $0 is set to the name of that file. If Bash is started with the
-c option (see Section 6.1 [Invoking Bash], page 91), then $0 is set to the first
argument after the string to be executed, if one is present. Otherwise, it is set
to the filename used to invoke Bash, as given by argument zero.

3.5 Shell Expansions

Expansion is performed on the command line after it has been split into tokens. There are
seven kinds of expansion performed:

tilde expansion
command substitution
word splitting
0,${}~~+~-+-+-+:=~-dirs +Ndirs +Ndirs -N$}:-s existence and that its value is not null; if the colon is omitted, the
operator tests only for existence.

${parameter:@*@*:-@*@*@@*@*@###@*@*%%%@*@*#%/&&&&&&& & t take any enclosing double
quotes into account.
Since backslash can escape , it can also escape a backslash in the replacement
string. This means that  will insert a literal backslash into the replacement,
so these two echo commands

var=abcdef
rep=
echo ${var/abc/\\&xyz}
echo ${var/abc/$rep}
will both output .
It should rarely be necessary to enclose only string in double quotes.
If the nocasematch shell option (see the description of shopt in Section 4.3.2
[The Shopt Builtin], page 71) is enabled, the match is performed without regard
to the case of alphabetic characters. If parameter is  or , the substitution
operation is applied to each positional parameter in turn, and the expansion is
the resultant list. If parameter is an array variable subscripted with  or ,
the substitution operation is applied to each member of the array in turn, and
the expansion is the resultant list.

${parameter^pattern}
${parameter^^pattern}
${parameter,pattern}
${parameter,,pattern}
${parameter@operator}
U u L Q E P A K a k
3.5.5 Arithmetic Expansion
$(( expression ))
3.5.6 Process Substitution
Process substitution allows a process*?[......?........***/*s collating sequence and character
set, is matched. If the first character following the  is a  or a  then any
character not enclosed is matched. A ][a-dx-z][abcdxyz][a-dx-z][abcdxyz][aBbCcDdxYyZz]C[]_[][]|.......\, and 
that did not result from one of the above expansions are removed.

3.6 Redirections

Before a command is executed, its input and output may be redirected using a special no-
tation interpreted by the shell. Redirection allows commandss lifetime
manually. The varredir_close shell option manages this behavior (see Section 4.3.2 [The
Shopt Builtin], page 71).

In the following descriptions, if the file descriptor number is omitted, and the first char-
acter of the redirection operator is , the redirection refers to the standard input (file
descriptor 0). If the first character of the redirection operator is , the redirection refers
to the standard output (file descriptor 1).

The word following the redirection operator in the following descriptions, unless other-
wise noted, is subjected to brace expansion, tilde expansion, parameter expansion, command
substitution, arithmetic expansion, quote removal, filename expansion, and word splitting.
If it expands to more than one word, Bash reports an error.

Note that the order of redirections is significant. For example, the command

ls > dirlist 2>&1

directs both standard output (file descriptor 1) and standard error (file descriptor 2) to the
file dirlist, while the command
ls 2>&1 > dirlist

directs only the standard output to file dirlist, because the standard error was made a copy
of the standard output before the standard output was redirected to dirlist.

Bash handles several filenames specially when they are used in redirections, as described
in the following table. If the operating system on which Bash is running provides these
special files, bash will use them; otherwise it will emulate them internally with the behavior
described below.

/dev/fd/fd
If fd is a valid integer, file descriptor fd is duplicated.
/dev/stdin File descriptor 0 is duplicated.
/dev/stdout File descriptor 1 is duplicated.
/dev/stderr File descriptor 2 is duplicated.
/dev/tcp/host/port

If host is a valid hostname or Internet address, and port is an integer port
number or service name, Bash attempts to open the corresponding TCP socket.

/dev/udp/host/port

If host is a valid hostname or Internet address, and port is an integer port
number or service name, Bash attempts to open the corresponding UDP socket.

A failure to open or create a file causes the redirection to fail.

Redirections using file descriptors greater than 9 should be used with care, as they may

conflict with file descriptors the shell uses internally.

3.6.1 Redirecting Input
Redirection of input causes the file whose name results from the expansion of word to be
opened for reading on file descriptor n, or the standard input (file descriptor 0) if n is not
specified.
[n]<word
3.6.2 Redirecting Output
Redirection of output causes the file whose name results from the expansion of word to be
opened for writing on file descriptor n, or the standard output (file descriptor 1) if n is not
specified. If the file does not exist it is created; if it does exist it is truncated to zero size.

The general format for redirecting output is:

[n]>[|]word

If the redirection operator is , and the noclobber option to the set builtin has been
enabled, the redirection will fail if the file whose name results from the expansion of word
exists and is a regular file. If the redirection operator is , or the redirection operator is
and the noclobber option is not enabled, the redirection is attempted even if the file
named by word exists.

3.6.3 Appending Redirected Output
[n]>>word
3.6.4 Redirecting Standard Output and Standard Error
This construct allows both the standard output (file descriptor 1) and the standard error
output (file descriptor 2) to be redirected to the file whose name is the expansion of word.

&>word # same as >word 2>&1

When using the second form, word may not expand to a number or .

If it does,
other redirection operators apply (see Duplicating File Descriptors below) for compatibility
reasons.

3.6.5 Appending Standard Output and Standard Error
This construct allows both the standard output (file descriptor 1) and the standard error
output (file descriptor 2) to be appended to the file whose name is the expansion of word.

The format for appending standard output and standard error is:

&>>word # This is semantically equivalent to >>word 2>&1

(see Duplicating File Descriptors below).

3.6.6 Here Documents
This type of redirection instructs the shell to read input from the current source until a line
containing only word (with no trailing blanks) is seen. All of the lines read up to that point
are then used as the standard input (or file descriptor n if n is specified) for a command.

The format of here-documents is:

[n]<<[\\$.

If the redirection operator is , then all leading tab characters are stripped from input
lines and the line containing delimiter. This allows here-documents within shell scripts to
be indented in a natural fashion.

Chapter 3: Basic Shell Features

41

3.6.7 Here Strings
A variant of here documents, the format is:

[n]<<< word

The word undergoes tilde expansion, parameter and variable expansion, command sub-
stitution, arithmetic expansion, and quote removal. Filename expansion and word splitting
are not performed. The result is supplied as a single string, with a newline appended, to
the command on its standard input (or file descriptor n if n is specified).

3.6.8 Duplicating File Descriptors
The redirection operator

[n]<&word

is used to duplicate input file descriptors. If word expands to one or more digits, the file
descriptor denoted by n is made to be a copy of that file descriptor. If the digits in word
do not specify a file descriptor open for input, a redirection error occurs. If word evaluates
to , file descriptor n is closed. If n is not specified, the standard input (file descriptor 0)
is used.

The operator

[n]>&word

is used similarly to duplicate output file descriptors.
If n is not specified, the standard
output (file descriptor 1) is used. If the digits in word do not specify a file descriptor open
for output, a redirection error occurs. If word evaluates to , file descriptor n is closed.
As a special case, if n is omitted, and word does not expand to one or more digits or ,
the standard output and standard error are redirected as described previously.

3.6.9 Moving File Descriptors
The redirection operator

[n]<&digit-

moves the file descriptor digit to file descriptor n, or the standard input (file descriptor 0)
if n is not specified. digit is closed after being duplicated to n.

Similarly, the redirection operator

[n]>&digit-

moves the file descriptor digit to file descriptor n, or the standard output (file descriptor 1)
if n is not specified.

3.6.10 Opening File Descriptors for Reading and Writing
The redirection operator

[n]<>word

causes the file whose name is the expansion of word to be opened for both reading and
writing on file descriptor n, or on file descriptor 0 if n is not specified. If the file does not
exist, it is created.

Chapter 3: Basic Shell Features

42

3.7 Executing Commands

3.7.1 Simple Command Expansion
When a simple command is executed, the shell performs the following expansions, assign-
ments, and redirections, from left to right, in the following order.

1. The words that the parser has marked as variable assignments (those preceding the

command name) and redirections are saved for later processing.

2. The words that are not variable assignments or redirections are expanded (see
Section 3.5 [Shell Expansions], page 24).
If any words remain after expansion, the
first word is taken to be the name of the command and the remaining words are the
arguments.

3. Redirections are performed as described above (see Section 3.6 [Redirections], page 38).
4. The text after the  in each variable assignment undergoes tilde expansion, parameter
expansion, command substitution, arithmetic expansion, and quote removal before
being assigned to the variable.

If no command name results, the variable assignments affect the current shell environ-
ment.
In the case of such a command (one that consists only of assignment statements
and redirections), assignment statements are performed before redirections. Otherwise, the
variables are added to the environment of the executed command and do not affect the cur-
rent shell environment. If any of the assignments attempts to assign a value to a readonly
variable, an error occurs, and the command exits with a non-zero status.

If no command name results, redirections are performed, but do not affect the current
shell environment. A redirection error causes the command to exit with a non-zero status.
If there is a command name left after expansion, execution proceeds as described below.
Otherwise, the command exits. If one of the expansions contained a command substitu-
tion, the exit status of the command is the exit status of the last command substitution
performed. If there were no command substitutions, the command exits with a status of
zero.

3.7.2 Command Search and Execution
After a command has been split into words, if it results in a simple command and an
optional list of arguments, the following actions are taken.

1. If the command name contains no slashes, the shell attempts to locate it. If there exists
a shell function by that name, that function is invoked as described in Section 3.3 [Shell
Functions], page 19.

2. If the name does not match a function, the shell searches for it in the list of shell

builtins. If a match is found, that builtin is invoked.

3. If the name is neither a shell function nor a builtin, and contains no slashes, Bash
searches each element of $PATH for a directory containing an executable file by that
name. Bash uses a hash table to remember the full pathnames of executable files to
avoid multiple PATH searches (see the description of hash in Section 4.1 [Bourne Shell
Builtins], page 48). A full search of the directories in $PATH is performed only if the
command is not found in the hash table. If the search is unsuccessful, the shell searches
for a defined shell function named command_not_found_handle. If that function exists,

Chapter 3: Basic Shell Features

43

it is invoked in a separate execution environment with the original command and the
original commands exit status becomes
the exit status of that subshell. If that function is not defined, the shell prints an error
message and returns an exit status of 127.

4. If the search is successful, or if the command name contains one or more slashes, the
shell executes the named program in a separate execution environment. Argument 0
is set to the name given, and the remaining arguments to the command are set to the
arguments supplied, if any.

5. If this execution fails because the file is not in executable format, and the file is not
a directory, it is assumed to be a shell script and the shell executes it as described in
Section 3.8 [Shell Scripts], page 46.

6. If the command was not begun asynchronously, the shell waits for the command to

complete and collects its exit status.

3.7.3 Command Execution Environment
The shell has an execution environment, which consists of the following:

the current working directory as set by cd, pushd, or popd, or inherited by the shell at

invocation

s parent
shell parameters that are set by variable assignment or with set or inherited from the

shell shell functions defined during execution or inherited from the shell options enabled at invocation (either by default or with command-line arguments) or

by set

shell aliases defined with alias (see Section 6.6 [Aliases], page 100)
the shell the current working directory
shell variables and functions marked for export, along with variables exported for the

command, passed in the environment (see Section 3.7.4 [Environment], page 44)

s parent, and

traps ignored by the shell are ignored

Chapter 3: Basic Shell Features

44

A command invoked in this separate environment cannot affect the shells execution environment.

Subshells spawned to execute command substitutions inherit the value of the -e option
from the parent shell. When not in posix mode, Bash clears the -e option in such subshells.
If a command is followed by a  and job control is not active, the default standard input
for the command is the empty file /dev/null. Otherwise, the invoked command inherits
the file descriptors of the calling shell as modified by redirections.

3.7.4 Environment
When a program is invoked it is given an array of strings called the environment. This is a
list of name-value pairs, of the form name=value.

Bash provides several ways to manipulate the environment. On invocation, the shell
scans its own environment and creates a parameter for each name found, automatically
marking it for export to child processes. Executed commands inherit the environment. The
export and  commands allow parameters and functions to be added to and
deleted from the environment. If the value of a parameter in the environment is modified, the
new value becomes part of the environment, replacing the old. The environment inherited
by any executed command consists of the shellexport -ndeclare -x$_s purposes, a command which exits with a zero exit status has succeeded.
A non-zero exit status indicates failure. This seemingly counter-intuitive scheme is used so
there is one well-defined way to indicate success and a variety of ways to indicate various
failure modes. When a command terminates on a fatal signal whose number is N, Bash
uses the value 128+N as the exit status.

If a command is not found, the child process created to execute it returns a status of

127. If a command is found but is not executable, the return status is 126.

If a command fails because of an error during expansion or redirection, the exit status

is greater than zero.

The exit status is used by the Bash conditional commands (see Section 3.2.5.2 [Con-
ditional Constructs], page 12) and some of the list constructs (see Section 3.2.4 [Lists],
page 10).

All of the Bash builtins return an exit status of zero if they succeed and a non-zero
status on failure, so they may be used by the conditional and list constructs. All builtins
return an exit status of 2 to indicate incorrect usage, generally invalid options or missing
arguments.

The exit status of the last command is available in the special parameter $?

(see

Section 3.4.2 [Special Parameters], page 23).

3.7.6 Signals
When Bash is interactive, in the absence of any traps, it ignores SIGTERM (so that  does not kill an interactive shell), and SIGINT is caught and handled (so that the wait
builtin is interruptible). When Bash receives a SIGINT, it breaks out of any executing loops.
In all cases, Bash ignores SIGQUIT. If job control is in effect (see Chapter 7 [Job Control],
page 113), Bash ignores SIGTTIN, SIGTTOU, and SIGTSTP.

Non-builtin commands started by Bash have signal handlers set to the values inherited
by the shell from its parent. When job control is not in effect, asynchronous commands
ignore SIGINT and SIGQUIT in addition to these inherited handlers. Commands run as a
result of command substitution ignore the keyboard-generated job control signals SIGTTIN,
SIGTTOU, and SIGTSTP.

The shell exits by default upon receipt of a SIGHUP. Before exiting, an interactive shell
resends the SIGHUP to all jobs, running or stopped. Stopped jobs are sent SIGCONT to
ensure that they receive the SIGHUP. To prevent the shell from sending the SIGHUP signal
to a particular job, it should be removed from the jobs table with the disown builtin (see
Section 7.2 [Job Control Builtins], page 114) or marked to not receive SIGHUP using disown
-h.

If the huponexit shell option has been set with shopt (see Section 4.3.2 [The Shopt

Builtin], page 71), Bash sends a SIGHUP to all jobs when an interactive login shell exits.

If Bash is waiting for a command to complete and receives a signal for which a trap
has been set, the trap will not be executed until the command completes. When Bash is
waiting for an asynchronous command via the wait builtin, the reception of a signal for
which a trap has been set will cause the wait builtin to return immediately with an exit
status greater than 128, immediately after which the trap is executed.

When job control is not enabled, and Bash is waiting for a foreground command to
complete, the shell receives keyboard-generated signals such as SIGINT (usually generated
by ) that users commonly intend to send to that command. This happens because the
shell and the command are in the same process group as the terminal, and  sends SIGINT
to all processes in that process group. See Chapter 7 [Job Control], page 113, for a more
in-depth discussion of process groups.

When Bash is running without job control enabled and receives SIGINT while waiting
for a foreground command, it waits until that foreground command terminates and then
decides what to do about the SIGINT:

1. If the command terminates due to the SIGINT, Bash concludes that the user meant to
end the entire script, and acts on the SIGINT (e.g., by running a SIGINT trap or exiting
itself);

2. If the pipeline does not terminate due to SIGINT, the program handled the SIGINT
itself and did not treat it as a fatal signal. In that case, Bash does not treat SIGINT
as a fatal signal, either, instead assuming that the SIGINT was used as part of the
programs command execution
mechanism. If the first line of a script begins with the two characters , the remainder
of the line specifies an interpreter for the program and, depending on the operating system,
one or more optional arguments for that interpreter. Thus, you can specify Bash, awk, Perl,
or some other interpreter and write the rest of the script file in that language.

The arguments to the interpreter consist of one or more optional arguments following
the interpreter name on the first line of the script file, followed by the name of the script
file, followed by the rest of the arguments supplied to the script. The details of how the
interpreter line is split into an interpreter name and a set of arguments vary across systems.
Bash will perform this action on operating systems that do not handle it themselves. Note
that some older versions of Unix limit the interpreter name and a single argument to a
maximum of 32 characters, so its a common idiom to use env to find bash even if it-----------:......--s parent. If n is omitted, the
exit status is that of the last command executed. Any trap on EXIT is executed
before the shell terminates.

export [-fn] [-p] [name[=value]]

Mark each name to be passed to child processes in the environment.
If the
-f option is supplied, the names refer to shell functions; otherwise the names
refer to shell variables. The -n option means to no longer mark each name for
export. If no names are supplied, or if the -p option is given, a list of names
of all exported variables is displayed. The -p option displays output in a form
that may be reused as input. If a variable name is followed by =value, the value
of the variable is set to value.
The return status is zero unless an invalid option is supplied, one of the names
is not a valid shell variable name, or -f is supplied with a name that is not a
shell function.

getopts optstring name [arg ...]

getopts is used by shell scripts to parse positional parameters. optstring con-
tains the option characters to be recognized; if a character is followed by a
colon, the option is expected to have an argument, which should be separated
from it by whitespace. The colon () and question mark () may not be
used as option characters. Each time it is invoked, getopts places the next
option in the shell variable name, initializing name if it does not exist, and the
index of the next argument to be processed into the variable OPTIND. OPTIND
is initialized to 1 each time the shell or a shell script is invoked. When an

Chapter 4: Shell Builtin Commands

51

option requires an argument, getopts places that argument into the variable
OPTARG. The shell does not reset OPTIND automatically; it must be manually
reset between multiple calls to getopts within the same shell invocation if a
new set of parameters is to be used.

When the end of options is encountered, getopts exits with a return value
greater than zero. OPTIND is set to the index of the first non-option argument,
and name is set to .

getopts normally parses the positional parameters, but if more arguments are
supplied as arg values, getopts parses those instead.

getopts can report errors in two ways. If the first character of optstring is a
colon, silent error reporting is used. In normal operation, diagnostic messages
are printed when invalid options or missing option arguments are encountered.
If the variable OPTERR is set to 0, no error messages will be displayed, even if
the first character of optstring is not a colon.

If an invalid option is seen, getopts places  into name and, if not silent,
prints an error message and unsets OPTARG.
If getopts is silent, the option
character found is placed in OPTARG and no diagnostic message is printed.

If a required argument is not found, and getopts is not silent, a question mark
() is placed in name, OPTARG is unset, and a diagnostic message is printed. If
getopts is silent, then a colon () is placed in name and OPTARG is set to the
option character found.

hash [-r] [-p filename] [-dt] [name]

Each time hash is invoked, it remembers the full pathnames of the commands
specified as name arguments, so they need not be searched for on subsequent
invocations. The commands are found by searching through the directories
listed in $PATH. Any previously-remembered pathname is discarded. The -p
option inhibits the path search, and filename is used as the location of name.
The -r option causes the shell to forget all remembered locations. The -d
option causes the shell to forget the remembered location of each name. If the
-t option is supplied, the full pathname to which each name corresponds is
printed. If multiple name arguments are supplied with -t, the name is printed
before the hashed full pathname. The -l option causes output to be displayed
in a format that may be reused as input. If no arguments are given, or if only -l
is supplied, information about remembered commands is printed. The return
status is zero unless a name is not found or an invalid option is supplied.

hash

pwd

pwd [-LP]

Print the absolute pathname of the current working directory. If the -P option
is supplied, the pathname printed will not contain symbolic links.
If the -L
option is supplied, the pathname printed may contain symbolic links. The
return status is zero unless an error is encountered while determining the name
of the current directory or an invalid option is supplied.

readonly [-aAf] [-p] [name[=value]] ...

Mark each name as readonly. The values of these names may not be changed
by subsequent assignment. If the -f option is supplied, each name refers to
a shell function. The -a option means each name refers to an indexed array
variable; the -A option means each name refers to an associative array variable.
If both options are supplied, -A takes precedence. If no name arguments are
given, or if the -p option is supplied, a list of all readonly names is printed.
The other options may be used to restrict the output to a subset of the set of
readonly names. The -p option causes output to be displayed in a format that
may be reused as input. If a variable name is followed by =value, the value of
the variable is set to value. The return status is zero unless an invalid option
is supplied, one of the name arguments is not a valid shell variable or function
name, or the -f option is supplied with a name that is not a shell function.

return

return [n]

Cause a shell function to stop executing and return the value n to its caller.
If n is not supplied, the return value is the exit status of the last command
executed in the function.
If return is executed by a trap handler, the last
command used to determine the status is the last command executed before
the trap handler. If return is executed during a DEBUG trap, the last command
used to determine the status is the last command executed by the trap handler
before return was invoked. return may also be used to terminate execution of
a script being executed with the . (source) builtin, returning either n or the
exit status of the last command executed within the script as the exit status
of the script. If n is supplied, the return value is its least significant 8 bits.
Any command associated with the RETURN trap is executed before execution
resumes after the function or script. The return status is non-zero if return is
supplied a non-numeric argument or is used outside a function and not during
the execution of a script by . or source.

shift

shift [n]

Shift the positional parameters to the left by n. The positional parameters
from n+1 . . . $# are renamed to $1 . . . $#-n. Parameters represented by the
numbers $# down to $#-n+1 are unset. n must be a non-negative number less
than or equal to $#. If n is zero or greater than $#, the positional parameters
are not changed. If n is not supplied, it is assumed to be 1. The return status
is zero unless n is greater than $# or less than zero, non-zero otherwise.

test
[

test expr

Evaluate a conditional expression expr and return a status of 0 (true) or 1
(false). Each operator and operand must be a separate argument. Expressions
are composed of the primaries described below in Section 6.4 [Bash Conditional

Chapter 4: Shell Builtin Commands

53

Expressions], page 96. test does not accept any options, nor does it accept
and ignore an argument of -- as signifying the end of options.

When the [ form is used, the last argument to the command must be a ].

Expressions may be combined using the following operators, listed in decreasing
order of precedence. The evaluation depends on the number of arguments; see
below. Operator precedence is used when there are five or more arguments.

! expr
( expr )
expr1 -a expr2
expr1 -o expr2

The test and [ builtins evaluate conditional expressions using a set of rules
based on the number of arguments.

0 arguments

The expression is false.

1 argument

The expression is true if, and only if, the argument is not null.

2 arguments

If the first argument is , the expression is true if and only if the
second argument is null. If the first argument is one of the unary
conditional operators (see Section 6.4 [Bash Conditional Expres-
sions], page 96), the expression is true if the unary test is true. If
the first argument is not a valid unary operator, the expression is
false.

3 arguments

The following conditions are applied in the order listed.

1. If the second argument is one of the binary conditional opera-
tors (see Section 6.4 [Bash Conditional Expressions], page 96),
the result of the expression is the result of the binary test using
the first and third arguments as operands. The  and 
operators are considered binary operators when there are three
arguments.

2. If the first argument is , the value is the negation of the
two-argument test using the second and third arguments.

3. If the first argument is exactly  and the third argument is
exactly , the result is the one-argument test of the second
argument.

4. Otherwise, the expression is false.

Chapter 4: Shell Builtin Commands
times
trap

4 arguments

The following conditions are applied in the order listed.

1. If the first argument is , the result is the negation of the
three-argument expression composed of the remaining argu-
ments.

2. If the first argument is exactly  and the fourth argument is
exactly , the result is the two-argument test of the second
and third arguments.

3. Otherwise, the expression is parsed and evaluated according to

precedence using the rules listed above.

5 or more arguments

The expression is parsed and evaluated according to precedence
using the rules listed above.

When used with test or , the  and  operators sort lexicographically
using ASCII ordering.

times

Print out the user and system times used by the shell and its children. The
return status is zero.

trap [-lp] [arg] [sigspec ...]

The commands in arg are to be read and executed when the shell receives
signal sigspec. If arg is absent (and there is a single sigspec) or equal to ,
each specified signals return status is being inverted using !. These are the same
conditions obeyed by the errexit (-e) option.
Signals ignored upon entry to the shell cannot be trapped or reset. Trapped
signals that are not being ignored are reset to their original values in a subshell
or subshell environment when one is created.
The return status is zero unless a sigspec does not specify a valid signal.

umask

umask [-p] [-S] [mode]

Set the shell process"\C-x\C-r":re-read-init-filecommand lss value. The nameref
attribute cannot be applied to array variables.

Make names readonly. These names cannot then be assigned values
by subsequent assignment statements or unset.

Give each name the trace attribute. Traced functions inherit the
DEBUG and RETURN traps from the calling shell. The trace attribute
has no special meaning for variables.

When the variable is assigned a value, all lower-case characters are
converted to upper-case. The lower-case attribute is disabled.

Mark each name for export to subsequent commands via the envi-
ronment.

-r

-t

-u

-x

Using  instead of  turns off the attribute instead, with the exceptions that
and  may not be used to destroy array variables and  will not remove
the readonly attribute. When used in a function, declare makes each name
local, as with the local command, unless the -g option is used. If a variable
name is followed by =value, the value of the variable is set to value.
When using -a or -A and the compound assignment syntax to create array
variables, additional attributes do not take effect until subsequent assignments.
The return status is zero unless an invalid option is encountered, an attempt
is made to define a function using , an attempt is made to assign
a value to a readonly variable, an attempt is made to assign a value to an
array variable without using the compound assignment syntax (see Section 6.7
[Arrays], page 100), one of the names is not a valid shell variable name, an
attempt is made to turn off readonly status for a readonly variable, an attempt
is made to turn off array status for an array variable, or an attempt is made to
display a non-existent function with -f.

echo [-neE] [arg ...]

Output the args, separated by spaces, terminated with a newline. The return
status is 0 unless a write error occurs. If -n is specified, the trailing newline is
suppressed. If the -e option is given, interpretation of the following backslash-
escaped characters is enabled. The -E option disables the interpretation of
these escape characters, even on systems where they are interpreted by default.
The xpg_echo shell option may be used to dynamically determine whether or
not echo expands these escape characters by default. echo does not interpret
-- to mean the end of options.
echo interprets the following escape sequences:

\a

\b

\c

alert (bell)

backspace

Chapter 4: Shell Builtin Commands
\e
\E
\f
\n
\r
\t
\v
\\

escape

form feed

new line

carriage return

horizontal tab

vertical tab

backslash

\0nnn

\xHH

\uHHHH

the eight-bit character whose value is the octal value nnn (zero to
three octal digits)

the eight-bit character whose value is the hexadecimal value HH
(one or two hex digits)

the Unicode (ISO/IEC 10646) character whose value is the hex-
adecimal value HHHH (one to four hex digits)

\UHHHHHHHH

enable

the Unicode (ISO/IEC 10646) character whose value is the hex-
adecimal value HHHHHHHH (one to eight hex digits)

enable [-a] [-dnps] [-f filename] [name ...]

Enable and disable builtin shell commands. Disabling a builtin allows a disk
command which has the same name as a shell builtin to be executed without
specifying a full pathname, even though the shell normally searches for builtins
before disk commands. If -n is used, the names become disabled. Otherwise
names are enabled. For example, to use the test binary found via $PATH
instead of the shell builtin version, type .
If the -p option is supplied, or no name arguments appear, a list of shell
builtins is printed. With no other arguments, the list consists of all enabled
shell builtins. The -a option means to list each builtin with an indication of
whether or not it is enabled.
The -f option means to load the new builtin command name from shared object
filename, on systems that support dynamic loading. Bash will use the value of
the BASH_LOADABLES_PATH variable as a colon-separated list of directories in
which to search for filename. The default is system-dependent. The -d option
will delete a builtin loaded with -f.
If there are no options, a list of the shell builtins is displayed. The -s option
restricts enable to the posix special builtins. If -s is used with -f, the new
builtin becomes a special builtin (see Section 4.4 [Special Builtins], page 77).
If no options are supplied and a name is not a shell builtin, enable will attempt
to load name from a shared object named name, as if the command were .
The return status is zero unless a name is not a shell builtin or there is an error
loading a new builtin from a shared object.

Chapter 4: Shell Builtin Commands

61

help

help [-dms] [pattern]

Display helpful information about builtin commands.
If pattern is specified,
help gives detailed help on all commands matching pattern, otherwise a list of
the builtins is printed.
Options, if supplied, have the following meanings:

-d

-m

-s

Display a short description of each pattern

Display the description of each pattern in a manpage-like format

Display only a short usage synopsis for each pattern

The return status is zero unless no command matches pattern.

let expression [expression ...]

The let builtin allows arithmetic to be performed on shell variables. Each
expression is evaluated according to the rules given below in Section 6.5 [Shell
If the last expression evaluates to 0, let returns 1;
Arithmetic], page 98.
otherwise 0 is returned.

local [option] name[=value] ...

For each argument, a local variable named name is created, and assigned value.
The option can be any of the options accepted by declare. local can only
be used within a function; it makes the variable name have a visible scope
restricted to that function and its children.
If name is , the set of shell
options is made local to the function in which local is invoked: shell options
changed using the set builtin inside the function are restored to their original
values when the function returns. The restore is effected as if a series of set
commands were executed to restore the values that were in place before the
function. The return status is zero unless local is used outside a function, an
invalid name is supplied, or name is a readonly variable.

logout [n]

Exit a login shell, returning a status of n to the shell\s default filename completion.

-i text

If Readline is being used to read the line, text is placed into the
editing buffer before editing begins.

-n nchars read returns after reading nchars characters rather than waiting
for a complete line of input, but honors a delimiter if fewer than
nchars characters are read before the delimiter.

-N nchars read returns after reading exactly nchars characters rather than
waiting for a complete line of input, unless EOF is encountered or

read times out. Delimiter characters encountered in the input are
not treated specially and do not cause read to return until nchars
characters are read. The result is not split on the characters in IFS;
the intent is that the variable is assigned exactly the characters read
(with the exception of backslash; see the -r option below).

-p prompt Display prompt, without a trailing newline, before attempting to
read any input. The prompt is displayed only if input is coming
from a terminal.

-r

-s

If this option is given, backslash does not act as an escape character.
The backslash is considered to be part of the line. In particular, a
backslash-newline pair may not then be used as a line continuation.

Silent mode. If input is coming from a terminal, characters are not
echoed.

-t timeout

Cause read to time out and return failure if a complete line of input
(or a specified number of characters) is not read within timeout sec-
onds. timeout may be a decimal number with a fractional portion
following the decimal point. This option is only effective if read
is reading input from a terminal, pipe, or other special file; it has
no effect when reading from regular files. If read times out, read
saves any partial input read into the specified variable name.
If
timeout is 0, read returns immediately, without trying to read any
data. The exit status is 0 if input is available on the specified file
descriptor, or the read will return EOF, non-zero otherwise. The
exit status is greater than 128 if the timeout is exceeded.

-u fd

Read input from file descriptor fd.

If no names are supplied, the line read, without the ending delimiter but oth-
erwise unmodified, is assigned to the variable REPLY. The exit status is zero,
unless end-of-file is encountered, read times out (in which case the status is
greater than 128), a variable assignment error (such as assigning to a readonly
variable) occurs, or an invalid file descriptor is supplied as the argument to -u.

readarray [-d delim] [-n count] [-O origin] [-s count]
[-t] [-u fd] [-C callback] [-c quantum] [array]
Read lines from the standard input into the indexed array variable array, or
from file descriptor fd if the -u option is supplied.
A synonym for mapfile.

source filename

A synonym for . (see Section 4.1 [Bourne Shell Builtins], page 48).

type [-afptP] [name ...]

readarray
source
type
typeset
ulimit

For each name, indicate how it would be interpreted if used as a command
name.
If the -t option is used, type prints a single word which is one of ,
, ,  or , if name is an alias, shell function,
shell builtin, disk file, or shell reserved word, respectively. If the name is not
found, then nothing is printed, and type returns a failure status.
If the -p option is used, type either returns the name of the disk file that would
be executed, or nothing if -t would not return .
The -P option forces a path search for each name, even if -t would not return
.
If a command is hashed, -p and -P print the hashed value, which is not neces-
sarily the file that appears first in $PATH.
If the -a option is used, type returns all of the places that contain an executable
named file. This includes aliases and functions, if and only if the -p option is
not also used.
If the -f option is used, type does not attempt to find shell functions, as with
the command builtin.
The return status is zero if all of the names are found, non-zero if any are not
found.

typeset [-afFgrxilnrtux] [-p] [name[=value] ...]

The typeset command is supplied for compatibility with the Korn shell. It is
a synonym for the declare builtin command.

ulimit [-HS] -a
ulimit [-HS] [-bcdefiklmnpqrstuvxPRT] [limit]

ulimit provides control over the resources available to processes started by the
shell, on systems that allow such control. If an option is given, it is interpreted
as follows:

-S

-H

-a

-b

-c

-d

-e

-f

-i

-k

Change and report the soft limit associated with a resource.

Change and report the hard limit associated with a resource.

All current limits are reported; no limits are set.

The maximum socket buffer size.

The maximum size of core files created.

The maximum size of a processs return status is being inverted with !. If a compound
command other than a subshell returns a non-zero status because
a command failed while -e was being ignored, the shell does not
exit. A trap on ERR, if set, is executed before the shell exits.
This option applies to the shell environment and each subshell en-
vironment separately (see Section 3.7.3 [Command Execution En-
vironment], page 43), and may cause subshells to exit before exe-
cuting all the commands in the subshell.
If a compound command or shell function executes in a context
where -e is being ignored, none of the commands executed within
the compound command or function body will be affected by the
-e setting, even if -e is set and a command returns a failure status.
If a compound command or shell function sets -e while executing

in a context where -e is ignored, that setting will not have any
effect until the compound command or the command containing
the function call completes.

Disable filename expansion (globbing).

Locate and remember (hash) commands as they are looked up for
execution. This option is enabled by default.

All arguments in the form of assignment statements are placed in
the environment for a command, not just those that precede the
command name.

Job control is enabled (see Chapter 7 [Job Control], page 113). All
processes run in a separate process group. When a background job
completes, the shell prints a line containing its exit status.

Read commands but do not execute them. This may be used to
check a script for syntax errors. This option is ignored by interac-
tive shells.

-f

-h

-k

-m

-n

-o option-name

Set the option corresponding to option-name:

allexport

Same as -a.

braceexpand

Same as -B.

emacs

Use an emacs-style line editing interface (see Chapter 8
[Command Line Editing], page 117). This also affects
the editing interface used for read -e.

errexit

Same as -e.

errtrace Same as -E.

functrace

Same as -T.

hashall

Same as -h.

histexpand

history

ignoreeof

Same as -H.

Enable command history, as described in Section 9.1
[Bash History Facilities], page 152. This option is on
by default in interactive shells.

An interactive shell will not exit upon reading EOF.

keyword

Same as -k.

monitor

Same as -m.

Chapter 4: Shell Builtin Commands

69

noclobber

Same as -C.

noexec

Same as -n.

noglob

Same as -f.

nolog

Currently ignored.

notify

Same as -b.

nounset

Same as -u.

onecmd

Same as -t.

physical Same as -P.

pipefail

posix

If set, the return value of a pipeline is the value of
the last (rightmost) command to exit with a non-zero
status, or zero if all commands in the pipeline exit suc-
cessfully. This option is disabled by default.

Change the behavior of Bash where the default opera-
tion differs from the posix standard to match the stan-
dard (see Section 6.11 [Bash POSIX Mode], page 106).
This is intended to make Bash behave as a strict su-
perset of that standard.

privileged

Same as -p.

verbose

Same as -v.

vi

Use a vi-style line editing interface. This also affects
the editing interface used for read -e.

xtrace

Same as -x.

Turn on privileged mode. In this mode, the $BASH_ENV and $ENV
files are not processed, shell functions are not inherited from the en-
vironment, and the SHELLOPTS, BASHOPTS, CDPATH and GLOBIGNORE
variables, if they appear in the environment, are ignored. If the shell
is started with the effective user (group) id not equal to the real
user (group) id, and the -p option is not supplied, these actions
are taken and the effective user id is set to the real user id. If the
-p option is supplied at startup, the effective user id is not reset.
Turning this option off causes the effective user and group ids to
be set to the real user and group ids.

Enable restricted shell mode. This option cannot be unset once it
has been set.

Exit after reading and executing one command.

Treat unset variables and parameters other than the special param-
eters  or , or array variables subscripted with  or , as an

-p
-r
-t
-u
-v
-x
-B
-C
-E
-H
-P
-T
--

error when performing parameter expansion. An error message will
be written to the standard error, and a non-interactive shell will
exit.

Print shell input lines as they are read.

Print a trace of simple commands, for commands, case commands,
select commands, and arithmetic for commands and their argu-
ments or associated word lists after they are expanded and before
they are executed. The value of the PS4 variable is expanded and
the resultant value is printed before the command and its expanded
arguments.

The shell will perform brace expansion (see Section 3.5.1 [Brace
Expansion], page 24). This option is on by default.

Prevent output redirection using , , and  from overwriting
existing files.

If set, any trap on ERR is inherited by shell functions, command
substitutions, and commands executed in a subshell environment.
The ERR trap is normally not inherited in such cases.

Enable  style history substitution (see Section 9.3 [History In-
teraction], page 154). This option is on by default for interactive
shells.

If set, do not resolve symbolic links when performing commands
such as cd which change the current directory. The physical direc-
tory is used instead. By default, Bash follows the logical chain of
directories when performing commands which change the current
directory.
For example, if /usr/sys is a symbolic link to /usr/local/sys
then:

$ cd /usr/sys; echo $PWD
/usr/sys
$ cd ..; pwd
/usr

If set -P is on, then:

$ cd /usr/sys; echo $PWD
/usr/local/sys
$ cd ..; pwd
/usr/local

If set, any trap on DEBUG and RETURN are inherited by shell func-
tions, command substitutions, and commands executed in a sub-
shell environment. The DEBUG and RETURN traps are normally not
inherited in such cases.

If no arguments follow this option, then the positional parame-
ters are unset. Otherwise, the positional parameters are set to the
arguments, even if some of them begin with a .

Chapter 4: Shell Builtin Commands

71

-

Signal the end of options, cause all remaining arguments to be
assigned to the positional parameters. The -x and -v options are
If there are no arguments, the positional parameters
turned off.
remain unchanged.

Using  rather than  causes these options to be turned off. The options can
also be used upon invocation of the shell. The current set of options may be
found in $-.
The remaining N arguments are positional parameters and are assigned, in
order, to $1, $2, . . . $N. The special parameter # is set to N.
The return status is always zero unless an invalid option is supplied.

4.3.2 The Shopt Builtin
This builtin allows you to change additional shell optional behavior.

shopt

shopt [-pqsu] [-o] [optname ...]

Toggle the values of settings controlling optional shell behavior. The settings
can be either those listed below, or, if the -o option is used, those available with
the -o option to the set builtin command (see Section 4.3.1 [The Set Builtin],
page 67). With no options, or with the -p option, a list of all settable options
is displayed, with an indication of whether or not each is set; if optnames are
supplied, the output is restricted to those options. The -p option causes output
to be displayed in a form that may be reused as input. Other options have the
following meanings:

-s -u -q -o

Enable (set) each optname.

Disable (unset) each optname.

Suppresses normal output; the return status indicates whether the
optname is set or unset. If multiple optname arguments are given
with -q, the return status is zero if all optnames are enabled; non-
zero otherwise.

Restricts the values of optname to be those defined for the -o option
to the set builtin (see Section 4.3.1 [The Set Builtin], page 67).

If either -s or -u is used with no optname arguments, shopt shows only those
options which are set or unset, respectively.
Unless otherwise noted, the shopt options are disabled (off) by default.
The return status when listing options is zero if all optnames are enabled, non-
zero otherwise. When setting or unsetting options, the return status is zero
unless an optname is not a valid shell option.
The list of shopt options is:

assoc_expand_once

If set, the shell suppresses multiple evaluation of associative array
subscripts during arithmetic expression evaluation, while executing
builtins that can perform variable assignments, and while executing
builtins that perform array dereferencing.
autocd

If set, a command name that is the name of a directory is executed
as if it were the argument to the cd command. This option is only
used by interactive shells.

cdable_vars

cdspell

checkhash

checkjobs

If this is set, an argument to the cd builtin command that is not
a directory is assumed to be the name of a variable whose value is
the directory to change to.

If set, minor errors in the spelling of a directory component in a cd
command will be corrected. The errors checked for are transposed
If a
characters, a missing character, and a character too many.
correction is found, the corrected path is printed, and the command
proceeds. This option is only used by interactive shells.

If this is set, Bash checks that a command found in the hash table
exists before trying to execute it. If a hashed command no longer
exists, a normal path search is performed.

If set, Bash lists the status of any stopped and running jobs before
exiting an interactive shell.
If any jobs are running, this causes
the exit to be deferred until a second exit is attempted without an
intervening command (see Chapter 7 [Job Control], page 113). The
shell always postpones exiting if any jobs are stopped.

checkwinsize

cmdhist

If set, Bash checks the window size after each external (non-builtin)
command and,
if necessary, updates the values of LINES and
COLUMNS. This option is enabled by default.

If set, Bash attempts to save all lines of a multiple-line command
in the same history entry. This allows easy re-editing of multi-line
commands. This option is enabled by default, but only has an
effect if command history is enabled (see Section 9.1 [Bash History
Facilities], page 152).

compat31
compat32
compat40
compat41
compat42
compat43
compat44 These control aspects of the shell....strings collating sequence is not taken into account, so
will not collate between  and , and upper-case and lower-
case ASCII characters will collate together.

globskipdots

If set, filename expansion will never match the filenames  and
, even if the pattern begins with a . This option is enabled
by default.

globstar

If set, the pattern  used in a filename expansion context will
match all files and zero or more directories and subdirectories. If
the pattern is followed by a , only directories and subdirectories
match.

gnu_errfmt

histappend

If set, shell error messages are written in the standard gnu error
message format.

If set, the history list is appended to the file named by the value of
the HISTFILE variable when the shell exits, rather than overwriting
the file.

Chapter 4: Shell Builtin Commands

75

histreedit

histverify

If set, and Readline is being used, a user is given the opportunity
to re-edit a failed history substitution.

If set, and Readline is being used, the results of history substitu-
tion are not immediately passed to the shell parser. Instead, the
resulting line is loaded into the Readline editing buffer, allowing
further modification.

hostcomplete

If set, and Readline is being used, Bash will attempt to perform
hostname completion when a word containing a  is being com-
pleted (see Section 8.4.6 [Commands For Completion], page 139).
This option is enabled by default.

huponexit

If set, Bash will send SIGHUP to all jobs when an interactive login
shell exits (see Section 3.7.6 [Signals], page 45).

inherit_errexit

If set, command substitution inherits the value of the errexit op-
tion, instead of unsetting it in the subshell environment. This op-
tion is enabled when posix mode is enabled.

interactive_comments

lastpipe

lithist

Allow a word beginning with  to cause that word and all remain-
ing characters on that line to be ignored in an interactive shell.
This option is enabled by default.

If set, and job control is not active, the shell runs the last command
of a pipeline not executed in the background in the current shell
environment.

If enabled, and the cmdhist option is enabled, multi-line commands
are saved to the history with embedded newlines rather than using
semicolon separators where possible.

localvar_inherit

If set, local variables inherit the value and attributes of a variable
of the same name that exists at a previous scope before any new
value is assigned. The nameref attribute is not inherited.

localvar_unset

If set, calling unset on local variables in previous function scopes
marks them so subsequent lookups find them unset until that func-
tion returns. This is identical to the behavior of unsetting local
variables at the current function scope.

login_shell

The shell sets this option if it is started as a login shell (see
Section 6.1 [Invoking Bash], page 91). The value may not be
changed.

Chapter 4: Shell Builtin Commands

76

mailwarn

If set, and a file that Bash is checking for mail has been accessed
since the last time it was checked, the message "The mail in mail-
file has been read" is displayed.

no_empty_cmd_completion

If set, and Readline is being used, Bash will not attempt to search
the PATH for possible completions when completion is attempted on
an empty line.

nocaseglob

If set, Bash matches filenames in a case-insensitive fashion when
performing filename expansion.

nocasematch

If set, Bash matches patterns in a case-insensitive fashion when
performing matching while executing case or [[ conditional com-
mands (see Section 3.2.5.2 [Conditional Constructs], page 12, when
performing pattern substitution word expansions, or when filtering
possible completions as part of programmable completion.

noexpand_translation

If set, Bash encloses the translated results of $"..." quoting in single
quotes instead of double quotes. If the string is not translated, this
has no effect.

nullglob

If set, Bash allows filename patterns which match no files to expand
to a null string, rather than themselves.

patsub_replacement

If set, Bash expands occurrences of  in the replacement string
of pattern substitution to the text matched by the pattern, as
described above (see Section 3.5.3 [Shell Parameter Expansion],
page 26). This option is enabled by default.

progcomp

If set, the programmable completion facilities (see Section 8.6 [Pro-
grammable Completion], page 143) are enabled. This option is
enabled by default.

progcomp_alias

If set, and programmable completion is enabled, Bash treats a com-
mand name that doesns home directory; the default for the cd builtin command. The
value of this variable is also used by tilde expansion (see Section 3.5.2 [Tilde
Expansion], page 25).

A list of characters that separate fields; used when the shell splits words as part
of expansion.

If this parameter is set to a filename or directory name and the MAILPATH
variable is not set, Bash informs the user of the arrival of mail in the specified
file or Maildir-format directory.

MAILPATH A colon-separated list of filenames which the shell periodically checks for new
mail. Each list entry can specify the message that is printed when new mail
arrives in the mail file by separating the filename from the message with a .
When used in the text of the message, $_ expands to the name of the current
mail file.

OPTARG

OPTIND

PATH

PS1

PS2

The value of the last option argument processed by the getopts builtin.

The index of the last option argument processed by the getopts builtin.

A colon-separated list of directories in which the shell looks for commands. A
zero-length (null) directory name in the value of PATH indicates the current
directory. A null directory name may appear as two adjacent colons, or as an
initial or trailing colon.

The primary prompt string. The default value is . See Section 6.9
[Controlling the Prompt], page 104, for the complete list of escape sequences
that are expanded before PS1 is displayed.

The secondary prompt string. The default value is . PS2 is expanded in the
same way as PS1 before being displayed.

5.2 Bash Variables

These variables are set or used by Bash, but other shells do not normally treat them
specially.

A few variables used by Bash are described in different chapters: variables for controlling

the job control facilities (see Section 7.3 [Job Control Variables], page 116).

_

($ , an underscore.) At shell startup, set to the pathname used to invoke the
shell or shell script being executed as passed in the environment or argument

Chapter 5: Shell Variables

79

list. Subsequently, expands to the last argument to the previous simple com-
mand executed in the foreground, after expansion. Also set to the full pathname
used to invoke each command executed and placed in the environment exported
to that command. When checking mail, this parameter holds the name of the
mail file.

BASH

The full pathname used to execute the current instance of Bash.

BASHOPTS A colon-separated list of enabled shell options. Each word in the list is a valid
argument for the -s option to the shopt builtin command (see Section 4.3.2
[The Shopt Builtin], page 71). The options appearing in BASHOPTS are those
reported as  by . If this variable is in the environment when Bash
starts up, each shell option in the list will be enabled before reading any startup
files. This variable is readonly.

BASHPID

Expands to the process ID of the current Bash process. This differs from $$
under certain circumstances, such as subshells that do not require Bash to be
re-initialized. Assignments to BASHPID have no effect. If BASHPID is unset, it
loses its special properties, even if it is subsequently reset.

BASH_ALIASES

An associative array variable whose members correspond to the internal list
of aliases as maintained by the alias builtin. (see Section 4.1 [Bourne Shell
Builtins], page 48). Elements added to this array appear in the alias list; how-
ever, unsetting array elements currently does not cause aliases to be removed
from the alias list. If BASH_ALIASES is unset, it loses its special properties, even
if it is subsequently reset.

BASH_ARGC

BASH_ARGV

An array variable whose values are the number of parameters in each frame
of the current bash execution call stack. The number of parameters to the
current subroutine (shell function or script executed with . or source) is at
the top of the stack. When a subroutine is executed, the number of parameters
passed is pushed onto BASH_ARGC. The shell sets BASH_ARGC only when in
extended debugging mode (see Section 4.3.2 [The Shopt Builtin], page 71, for
a description of the extdebug option to the shopt builtin). Setting extdebug
after the shell has started to execute a script, or referencing this variable when
extdebug is not set, may result in inconsistent values.

An array variable containing all of the parameters in the current bash execution
call stack. The final parameter of the last subroutine call is at the top of the
stack; the first parameter of the initial call is at the bottom. When a subroutine
is executed, the parameters supplied are pushed onto BASH_ARGV. The shell
sets BASH_ARGV only when in extended debugging mode (see Section 4.3.2 [The
Shopt Builtin], page 71, for a description of the extdebug option to the shopt
builtin). Setting extdebug after the shell has started to execute a script, or
referencing this variable when extdebug is not set, may result in inconsistent
values.

Chapter 5: Shell Variables
BASH_ARGV0
BASH_CMDS

When referenced, this variable expands to the name of the shell or shell script
(identical to $0; See Section 3.4.2 [Special Parameters], page 23, for the de-
scription of special parameter 0). Assignment to BASH_ARGV0 causes the value
assigned to also be assigned to $0. If BASH_ARGV0 is unset, it loses its special
properties, even if it is subsequently reset.

An associative array variable whose members correspond to the internal hash
table of commands as maintained by the hash builtin (see Section 4.1 [Bourne
Shell Builtins], page 48). Elements added to this array appear in the hash
table; however, unsetting array elements currently does not cause command
names to be removed from the hash table. If BASH_CMDS is unset, it loses its
special properties, even if it is subsequently reset.

BASH_COMMAND

The command currently being executed or about to be executed, unless the
shell is executing a command as the result of a trap, in which case it is the
command executing at the time of the trap. If BASH_COMMAND is unset, it loses
its special properties, even if it is subsequently reset.

BASH_COMPAT

The value is used to set the shell=~set -x?!@%t.o:~!quick substitution^#ignorespaceignoredupsignorebothignorespaceignoredupserasedups*&&&[ ]*$s parent process. This variable is readonly.

PROMPT_COMMAND

If this variable is set, and is an array, the value of each set element is interpreted
as a command to execute before printing the primary prompt ($PS1). If this is
set but not an array variable, its value is used as a command to execute instead.

PROMPT_DIRTRIM
If set to a number greater than zero, the value is used as the number of trailing
directory components to retain when expanding the \w and \W prompt string es-
capes (see Section 6.9 [Controlling the Prompt], page 104). Characters removed
are replaced with an ellipsis.

The value of this parameter is expanded like PS1 and displayed by interactive
shells after reading a command and before the command is executed.

The value of this variable is used as the prompt for the select command. If
this variable is not set, the select command prompts with 

The value of this parameter is expanded like PS1 and the expanded value is
the prompt printed before the command line is echoed when the -x option is
set (see Section 4.3.1 [The Set Builtin], page 67). The first character of the
expanded value is replicated multiple times, as necessary, to indicate multiple
levels of indirection. The default is .

The current working directory as set by the cd builtin.

Each time this parameter is referenced, it expands to a random integer between
0 and 32767. Assigning a value to this variable seeds the random number gener-
ator. If RANDOM is unset, it loses its special properties, even if it is subsequently
reset.

PS0
PS3
PS4
PWD
RANDOM
READLINE_ARGUMENT

Any numeric argument given to a Readline command that was defined using
(see Section 4.2 [Bash Builtins], page 55, when it was invoked.

READLINE_LINE

The contents of the Readline line buffer, for use with  (see Section 4.2
[Bash Builtins], page 55).

READLINE_MARK

The position of the mark (saved insertion point) in the Readline line buffer, for
use with  (see Section 4.2 [Bash Builtins], page 55). The characters
between the insertion point and the mark are often called the region.

READLINE_POINT

The position of the insertion point in the Readline line buffer, for use with  (see Section 4.2 [Bash Builtins], page 55).

REPLY

The default variable for the read builtin.

SECONDS

This variable expands to the number of seconds since the shell was started.
Assignment to this variable resets the count to the value assigned, and the
expanded value becomes the value assigned plus the number of seconds since
the assignment. The number of seconds at shell invocation and the current
time are always determined by querying the system clock. If SECONDS is unset,
it loses its special properties, even if it is subsequently reset.

SHELL

This environment variable expands to the full pathname to the shell. If it is not
set when the shell starts, Bash assigns to it the full pathname of the current
useronset -o%%\nreal\t%3lR\nuser\t%3lU\nsys\t%3lSs use.

UID:The numeric real user id of the current user. This variable is readonly.
6.1 Invoking Bash
bash [long-opt] [-ir] [-abefhkmnptuvxdBCDHP] [-o option]
[-O shopt_option] [argument ...]
bash [long-opt] [-abefhkmnptuvxdBCDHP] [-o option]
[-O shopt_option] -c string [argument ...]
bash [long-opt] -s [-abefhkmnptuvxdBCDHP] [-o option]
[-O shopt_option] [argument ...]

All of the single-character options used with the set builtin (see Section 4.3.1 [The Set
Builtin], page 67) can be used as options when the shell is invoked.
In addition, there
are several multi-character options that you can use. These options must appear on the
command line before the single-character options to be recognized.

--debugger

Arrange for the debugger profile to be executed before the shell starts. Turns
on extended debugging mode (see Section 4.3.2 [The Shopt Builtin], page 71,
for a description of the extdebug option to the shopt builtin).

--dump-po-strings

A list of all double-quoted strings preceded by  is printed on the standard
output in the gnu gettext PO (portable object) file format. Equivalent to -D
except for the output format.

--dump-strings

Equivalent to -D.

--help

Display a usage message on standard output and exit successfully.

--init-file filename
--rcfile filename

Execute commands from filename (instead of ~/.bashrc) in an interactive shell.

--login

Equivalent to -l.

--noediting

Do not use the gnu Readline library (see Chapter 8 [Command Line Editing],
page 117) to read command lines when the shell is interactive.

--noprofile

--norc

--posix

Dont read the ~/.bashrc initialization file in an interactive shell. This is on
by default if the shell is invoked as sh.
Change the behavior of Bash where the default operation differs from the posix
standard to match the standard. This is intended to make Bash behave as a
strict superset of that standard. See Section 6.11 [Bash POSIX Mode], page 106,
for a description of the Bash posix mode.

Chapter 6: Bash Features

92

--restricted

Make the shell a restricted shell (see Section 6.10 [The Restricted Shell],
page 105).

--verbose

--version

Equivalent to -v. Print shell input lines as theyexec -l bashexec bash -lexec bash --login$-s exit status
is the exit status of the last command executed in the script. If no commands are executed,
the exit status is 0.

6.2 Bash Startup Files

This section describes how Bash executes its startup files. If any of the files exist but cannot
be read, Bash reports an error. Tildes are expanded in filenames as described above under
Tilde Expansion (see Section 3.5.2 [Tilde Expansion], page 25).

Interactive shells are described in Section 6.3 [Interactive Shells], page 94.

Invoked as an interactive login shell, or with --login
When Bash is invoked as an interactive login shell, or as a non-interactive shell with the
--login option, it first reads and executes commands from the file /etc/profile, if that
file exists. After reading that file, it looks for ~/.bash_profile, ~/.bash_login, and
~/.profile, in that order, and reads and executes commands from the first one that exists
and is readable. The --noprofile option may be used when the shell is started to inhibit
this behavior.

When an interactive login shell exits, or a non-interactive login shell executes the exit
builtin command, Bash reads and executes commands from the file ~/.bash_logout, if it
exists.

Invoked as an interactive non-login shell
When an interactive shell that is not a login shell is started, Bash reads and executes
commands from ~/.bashrc, if that file exists. This may be inhibited by using the --norc
option. The --rcfile file option will force Bash to read and execute commands from file
instead of ~/.bashrc.

So, typically, your ~/.bash_profile contains the line

if [ -f ~/.bashrc ]; then . ~/.bashrc; fi

after (or before) any login-specific initializations.

Invoked non-interactively
When Bash is started non-interactively, to run a shell script, for example, it looks for the
variable BASH_ENV in the environment, expands its value if it appears there, and uses the

Chapter 6: Bash Features

94

expanded value as the name of a file to read and execute. Bash behaves as if the following
command were executed:

if [ -n "$BASH_ENV" ]; then . "$BASH_ENV"; fi

but the value of the PATH variable is not used to search for the filename.

As noted above, if a non-interactive shell is invoked with the --login option, Bash

attempts to read and execute commands from the login shell startup files.

Invoked with name sh
If Bash is invoked with the name sh, it tries to mimic the startup behavior of historical
versions of sh as closely as possible, while conforming to the posix standard as well.

When invoked as an interactive login shell, or as a non-interactive shell with the
--login option, it first attempts to read and execute commands from /etc/profile and
~/.profile, in that order. The --noprofile option may be used to inhibit this behavior.
When invoked as an interactive shell with the name sh, Bash looks for the variable ENV,
expands its value if it is defined, and uses the expanded value as the name of a file to read
and execute. Since a shell invoked as sh does not attempt to read and execute commands
from any other startup files, the --rcfile option has no effect. A non-interactive shell
invoked with the name sh does not attempt to read any other startup files.

When invoked as sh, Bash enters posix mode after the startup files are read.

Invoked in posix mode
When Bash is started in posix mode, as with the --posix command line option, it follows
the posix standard for startup files. In this mode, interactive shells expand the ENV variable
and commands are read and executed from the file whose name is the expanded value. No
other startup files are read.

Invoked by remote shell daemon
Bash attempts to determine when it is being run with its standard input connected to a
network connection, as when executed by the historical remote shell daemon, usually rshd,
or the secure shell daemon sshd. If Bash determines it is being run non-interactively in this
fashion, it reads and executes commands from ~/.bashrc, if that file exists and is readable.
It will not do this if invoked as sh. The --norc option may be used to inhibit this behavior,
and the --rcfile option may be used to force another file to be read, but neither rshd nor
sshd generally invoke the shell with those options or allow them to be specified.

Invoked with unequal effective and real uid/gids
If Bash is started with the effective user (group) id not equal to the real user (group) id,
and the -p option is not supplied, no startup files are read, shell functions are not inherited
from the environment, the SHELLOPTS, BASHOPTS, CDPATH, and GLOBIGNORE variables, if
they appear in the environment, are ignored, and the effective user id is set to the real user
id. If the -p option is supplied at invocation, the startup behavior is the same, but the
effective user id is not reset.

6.3 Interactive Shells

Chapter 6: Bash Features

95

6.3.1 What is an Interactive Shell?
An interactive shell is one started without non-option arguments (unless -s is specified)
and without specifying the -c option, whose input and error output are both connected to
terminals (as determined by isatty(3)), or one started with the -i option.

An interactive shell generally reads from and writes to a user-s terminal.

6. Bash inspects the value of the ignoreeof option to set -o instead of exiting imme-
diately when it receives an EOF on its standard input when reading a command (see
Section 4.3.1 [The Set Builtin], page 67).

Chapter 6: Bash Features

96

7. Command history (see Section 9.1 [Bash History Facilities], page 152) and history
expansion (see Section 9.3 [History Interaction], page 154) are enabled by default.
Bash will save the command history to the file named by $HISTFILE when a shell with
history enabled exits.


11. An interactive login shell sends a SIGHUP to all jobs on exit if the huponexit shell

option has been enabled (see Section 3.7.6 [Signals], page 45).

12. The -n invocation option is ignored, and  has no effect (see Section 4.3.1 [The

Set Builtin], page 67).

13. Bash will check for mail periodically, depending on the values of the MAIL, MAILPATH,

and MAILCHECK shell variables (see Section 5.2 [Bash Variables], page 78).

14. Expansion errors due to references to unbound shell variables after  has been

enabled will not cause the shell to exit (see Section 4.3.1 [The Set Builtin], page 67).

15. The shell will not exit on expansion errors caused by var being unset or null in
${var:?word} expansions (see Section 3.5.3 [Shell Parameter Expansion], page 26).

16. Redirection errors encountered by shell builtins will not cause the shell to exit.
17. When running in posix mode, a special builtin returning an error status will not cause

the shell to exit (see Section 6.11 [Bash POSIX Mode], page 106).

18. A failed exec will not cause the shell to exit (see Section 4.1 [Bourne Shell Builtins],

page 48).

19. Parser syntax errors will not cause the shell to exit.
20. If the cdspell shell option is enabled, the shell will attempt simple spelling correction
for directory arguments to the cd builtin (see the description of the cdspell option to
the shopt builtin in Section 4.3.2 [The Shopt Builtin], page 71). The cdspell option
is only effective in interactive shells.

21. The shell will check the value of the TMOUT variable and exit if a command is not
read within the specified number of seconds after printing $PS1 (see Section 5.2 [Bash
Variables], page 78).


Conditional expressions are used by the [[ compound command (see Section 3.2.5.2 [Condi-
tional Constructs], page 12) and the test and [ builtin commands (see Section 4.1 [Bourne
Shell Builtins], page 48). The test and [ commands determine their behavior based on
the number of arguments; see the descriptions of those commands for any other command-
specific actions.

Expressions may be unary or binary, and are formed from the following primaries. Unary
expressions are often used to examine the status of a file. There are string operators and
numeric comparison operators as well. Bash handles several filenames specially when they
are used in expressions. If the operating system on which Bash is running provides these
special files, Bash will use them; otherwise it will emulate them internally with this behavior:

If the file argument to one of the primaries is of the form /dev/fd/N, then file descriptor N
is checked. If the file argument to one of the primaries is one of /dev/stdin, /dev/stdout,
or /dev/stderr, file descriptor 0, 1, or 2, respectively, is checked.

When used with [[, the  and  operators sort lexicographically using the current

locale. The test command uses ASCII ordering.

Unless otherwise specified, primaries that operate on files follow symbolic links and

operate on the target of the link, rather than the link itself.

-a file True if file exists.
-b file True if file exists and is a block special file.
-c file True if file exists and is a character special file.
-d file True if file exists and is a directory.
-e file True if file exists.
-f file True if file exists and is a regular file.
-g file True if file exists and its set-group-id bit is set.
-h file True if file exists and is a symbolic link.
-k file True if file exists and its "sticky" bit is set.
-p file True if file exists and is a named pipe (FIFO).
-r file True if file exists and is readable.
-s file True if file exists and has a size greater than zero.
-t fd True if file descriptor fd is open and refers to a terminal.
-u file True if file exists and its set-user-id bit is set.
-w file True if file exists and is writable.
-x file True if file exists and is executable.
-G file True if file exists and is owned by the effective group id.
-L file True if file exists and is a symbolic link.
-N file True if file exists and has been modified since it was last read.
-O file True if file exists and is owned by the effective user id.
-S file True if file exists and is a socket.
file1 -ef file2 True if file1 and file2 refer to the same device and inode numbers.
file1 -nt file2 True if file1 is newer (according to modification date) than file2, or if file1 exists and file2 does not.
file1 -ot file2 True if file1 is older than file2, or if file2 exists and file1 does not.
-o optname True if the shell option optname is enabled. The list of options appears in the description of the -o option to the set builtin (see Section 4.3.1 [The Set Builtin], page 67).
-v varname True if the shell variable varname is set (has been assigned a value).
-R varname True if the shell variable varname is set and is a name reference.
-z string True if the length of string is zero.
-n string string True if the length of string is non-zero.
string1 == string2 string1 = string2 True if the strings are equal. When used with the [[ command, this per- forms pattern matching as described above (see Section 3.2.5.2 [Conditional Constructs], page 12).  should be used with the test command for posix conformance.
string1 != string2 True if the strings are not equal.
string1 < string2 True if string1 sorts before string2 lexicographically.
string1 > string2 True if string1 sorts after string2 lexicographically.
arg1 OP arg2  OP is one of ‘-eq’, ‘-ne’, ‘-lt’, ‘-le’, ‘-gt’, or ‘-ge’.
id++ id-- variable post-increment and post-decrement
++id --id variable pre-increment and pre-decrement
- + unary minus and plus
! ~ logical and bitwise negation
** exponentiation
* / % multiplication, division, remainder
+ - addition, subtraction
<< >> left and right bitwise shifts
<= >= < > comparison
== != equality and inequality
& ^ | && ||
bitwise AND bitwise exclusive OR bitwise OR logical AND logical OR
expr ? expr : expr conditional operator
= *= /= %= += -= <<= >>= &= ^= |= assignment
expr1 , expr2 comma

Shell variables are allowed as operands; parameter expansion is performed before the
expression is evaluated. Within an expression, shell variables may also be referenced by
name without using the parameter expansion syntax. A shell variable that is null or unset
evaluates to 0 when referenced by name without using the parameter expansion syntax.
The value of a variable is evaluated as an arithmetic expression when it is referenced, or
when a variable which has been given the integer attribute using  is assigned
a value. A null value evaluates to 0. A shell variable need not have its integer attribute
turned on to be used in an expression.

Integer constants follow the C language definition, without suffixes or character con-
stants. Constants with a leading 0 are interpreted as octal numbers. A leading  or 
denotes hexadecimal. Otherwise, numbers take the form [base#]n, where the optional base
is a decimal number between 2 and 64 representing the arithmetic base, and n is a number
in that base. If base# is omitted, then base 10 is used. When specifying n, if a non-digit is
required, the digits greater than 9 are represented by the lowercase letters, the uppercase
letters, , and , in that order. If base is less than or equal to 36, lowercase and uppercase
letters may be used interchangeably to represent numbers between 10 and 35.

Operators are evaluated in order of precedence. Sub-expressions in parentheses are

evaluated first and may override the precedence rules above.

Chapter 6: Bash Features

100

6.6 Aliases

Aliases allow a string to be substituted for a word when it is used as the first word of a
simple command. The shell maintains a list of aliases that may be set and unset with the
alias and unalias builtin commands.

The first word of each simple command, if unquoted, is checked to see if it has an alias.
If so, that word is replaced by the text of the alias. The characters , , =+=s filename expansion operators. If the subscript is
or , the word expands to all members of the array name. These subscripts differ only
when the word appears within double quotes. If the word is double-quoted, ${name[*]}
expands to a single word with the value of each array member separated by the first charac-
ter of the IFS variable, and ${name[@]} expands each element of name to a separate word.
When there are no array members, ${name[@]} expands to nothing. If the double-quoted
expansion occurs within a word, the expansion of the first parameter is joined with the
beginning part of the original word, and the expansion of the last parameter is joined with
the last part of the original word. This is analogous to the expansion of the special param-
eters  and . ${#name[subscript]} expands to the length of ${name[subscript]}. If
subscript is  or , the expansion is the number of elements in the array. If the subscript

Chapter 6: Bash Features

102

used to reference an element of an indexed array evaluates to a number less than zero, it
is interpreted as relative to one greater than the maximum index of the array, so negative
indices count back from the end of the array, and an index of -1 refers to the last element.

Referencing an array variable without a subscript is equivalent to referencing with a
subscript of 0. Any reference to a variable using a valid subscript is legal, and bash will
create an array if necessary.

An array variable is considered set if a subscript has been assigned a value. The null

string is a valid value.

It is possible to obtain the keys (indices) of an array as well as the values. ${!name[@]}
and ${!name[*]} expand to the indices assigned in array variable name. The treatment
when in double quotes is similar to the expansion of the special parameters  and 
within double quotes.

The unset builtin is used to destroy arrays. unset name[subscript] destroys the array
element at index subscript. Negative subscripts to indexed arrays are interpreted as de-
scribed above. Unsetting the last element of an array variable does not unset the variable.
unset name, where name is an array, removes the entire array. unset name[subscript]
behaves differently depending on the array type when given a subscript of  or . When
name is an associative array, it removes the element with key  or .
If name is an
indexed array, unset removes all of the elements, but does not remove the array itself.

When using a variable name with a subscript as an argument to a command, such as
with unset, without using the word expansion syntax described above, the argument is
subject to the shell.s terminal device name.

A newline.

A carriage return.

The name of the shell, the basename of $0 (the portion following the final slash).

Chapter 6: Bash Features

105

\t

\T

\@

\A

\u

\v

\V

\w

\W

\!

\#

\$

The time, in 24-hour HH:MM:SS format.

The time, in 12-hour HH:MM:SS format.

The time, in 12-hour am/pm format.

The time, in 24-hour HH:MM format.

The username of the current user.

The version of Bash (e.g., 2.00)

The release of Bash, version + patchlevel (e.g., 2.00.0)

The value of the PWD shell variable ($PWD), with $HOME abbreviated with a tilde
(uses the $PROMPT_DIRTRIM variable).

The basename of $PWD, with $HOME abbreviated with a tilde.

The history number of this command.

The command number of this command.

If the effective uid is 0, #, otherwise $.

\nnn

The character whose ASCII code is the octal value nnn.

\\

\[

\]

A backslash.

Begin a sequence of non-printing characters. This could be used to embed a
terminal control sequence into the prompt.

End a sequence of non-printing characters.

The command number and the history number are usually different: the history number
of a command is its position in the history list, which may include commands restored from
the history file (see Section 9.1 [Bash History Facilities], page 152), while the command
number is the position in the sequence of commands executed during the current shell
session.

After the string is decoded, it is expanded via parameter expansion, command substitu-
tion, arithmetic expansion, and quote removal, subject to the value of the promptvars shell
option (see Section 4.3.2 [The Shopt Builtin], page 71). This can have unwanted side effects
if escaped portions of the string appear within command substitution or contain characters
special to word expansion.

6.10 The Restricted Shell

If Bash is started with the name rbash, or the --restricted or -r option is supplied at
invocation, the shell becomes restricted. A restricted shell is used to set up an environment
more controlled than the standard shell. A restricted shell behaves identically to bash with
the exception that the following are disallowed or not performed:

Setting or unsetting the values of the SHELL, PATH, HISTFILE, ENV, or BASH_ENV vari-

ables.

Specifying a filename containing a slash as an argument to the . builtin command.
Specifying a filename containing a slash as an argument to the -p option to the hash

builtin command.

Parsing the value of SHELLOPTS from the shell environment at startup.
>>|<>>&&>>> Using the exec builtin to replace the shell with another command.
Using the enable builtin command to enable disabled shell builtins.
Turning off restricted mode with  or .

These restrictions are enforced after any startup files are read.
When a command that is found to be a shell script is executed (see Section 3.8 [Shell
Scripts], page 46), rbash turns off any restrictions in the shell spawned to execute the script.
The restricted shell mode is only one component of a useful restricted environment. It
should be accompanied by setting PATH to a value that allows execution of only a few verified
commands (commands that allow shell escapes are particularly vulnerable), changing the
current directory to a non-writable directory other than $HOME after login, not allowing the
restricted shell to execute shell scripts, and cleaning the environment of variables that cause
some commands to modify their behavior (e.g., VISUAL or PAGER).

Modern systems provide more secure ways to implement a restricted environment, such

as jails, zones, or containers.

6.11 Bash POSIX Mode

Starting Bash with the --posix command-line option or executing  while
Bash is running will cause Bash to conform more closely to the posix standard by changing
the behavior to match that specified by posix in areas where the Bash default differs.

When invoked as sh, Bash enters posix mode after reading the startup files.
The following list is whatposix modeshopt -s checkhashDone(status)Stopped(signame)!!!!-!#?*kill -lSIGSIGt check the first argument for a possible signal specification
and revert the signal handling to the original disposition if it is, unless that argument
consists solely of digits and is a valid signal number. If users want to reset the handler
for a given signal to the original disposition, they should use  as the first argument.
42. trap -p displays signals whose dispositions are set to SIG DFL and those that were

ignored when the shell started.

43. The . and source builtins do not search the current directory for the filename argument

if it is not found by searching PATH.

44. Enabling posix mode has the effect of setting the inherit_errexit option, so subshells
spawned to execute command substitutions inherit the value of the -e option from the
parent shell. When the inherit_errexit option is not enabled, Bash clears the -e
option in such subshells.

Chapter 6: Bash Features

109

45. Enabling posix mode has the effect of setting the shift_verbose option, so numeric
arguments to shift that exceed the number of positional parameters will result in an
error message.

46. When the alias builtin displays alias definitions, it does not display them with a

leading  unless the -p option is supplied.

47. When the set builtin is invoked without options, it does not display shell function

names and definitions.

48. When the set builtin is invoked without options, it displays variable values without
quotes, unless they contain shell metacharacters, even if the result contains nonprinting
characters.

49. When the cd builtin is invoked in logical mode, and the pathname constructed from
$PWD and the directory name supplied as an argument does not refer to an existing
directory, cd will fail instead of falling back to physical mode.

50. When the cd builtin cannot change a directory because the length of the pathname
constructed from $PWD and the directory name supplied as an argument exceeds PATH_
MAX when all symbolic links are expanded, cd will fail instead of attempting to use only
the supplied directory name.

51. The pwd builtin verifies that the value it prints is the same as the current directory,

even if it is not asked to check the file system with the -P option.

52. When listing the history, the fc builtin does not include an indication of whether or

not a history entry has been modified.

53. The default editor used by fc is ed.

54. The type and command builtins will not report a non-executable file as having been
found, though the shell will attempt to execute such a file if it is the only so-named file
found in $PATH.

55. The vi editing mode will invoke the vi editor directly when the  command is run,

instead of checking $VISUAL and $EDITOR.

56. When the xpg_echo option is enabled, Bash does not attempt to interpret any ar-
guments to echo as options. Each argument is displayed, after escape characters are
converted.

57. The ulimit builtin uses a block size of 512 bytes for the -c and -f options.

58. The arrival of SIGCHLD when a trap is set on SIGCHLD does not interrupt the wait
builtin and cause it to return immediately. The trap command is run once for each
child that exits.

59. The read builtin may be interrupted by a signal for which a trap has been set. If Bash
receives a trapped signal while executing read, the trap handler executes and read
returns an exit status greater than 128.

60. The printf builtin uses double (via strtod) to convert arguments corresponding to
floating point conversion specifiers, instead of long double if itLs available.

61. Bash removes an exited background process each option is mutually exclusive. The compatibility level
is intended to allow users to select behavior from previous versions that is incompatible
with newer versions while they migrate scripts to use current features and behavior. It quoting the rhs of the [[ command interrupting a command list such as "a ; b ; c" causes the execution of the
next command in the list (in bash-4.0 and later versions, the shell acts as
if it received the interrupt, so interrupting one command in a list aborts
the execution of the entire list)

<>s collation sequence and strcoll(3).

in posix mode, the parser requires that an even number of single quotes
occur in the word portion of a double-quoted ${. . . } parameter expansion
and treats them specially, so that characters within the single quotes are
considered quoted (this is posix interpretation 221)

in posix mode, single quotes are considered special when expanding the
word portion of a double-quoted ${. . . } parameter expansion and can be
used to quote a closing brace or other special character (this is part of
posix interpretation 221); in later versions, single quotes are not special
within double-quoted word expansions

(1 2) word expansion errors are considered non-fatal errors that cause the current
command to fail, even in posix mode (the default behavior is to make them
fatal errors that cause the shell to exit)

the shell sets up the values used by BASH_ARGV and BASH_ARGC so they
can expand to the shell a subshell inherits loops from its parent context, so break or continue
will cause the subshell to exit. Bash-5.0 and later reset the loop state to
prevent the exit

Bash-5.1 changed the way $RANDOM is generated to introduce slightly more
randomness. If the shell compatibility level is set to 50 or lower, it reverts
to the method from bash-5.0 and previous versions, so seeding the random
number generator by assigning a value to RANDOM will produce the same
sequence as in bash-5.0

The unset builtin will unset the array a given an argument like .
Bash-5.2 will unset an element with key  (associative arrays) or remove
all the elements without unsetting the array (indexed arrays)

expressions used as arguments to arithmetic operators in the [[ conditional

command can be expanded more than once

the expressions in the $(( ... )) word expansion can be expanded more

than once

test -v, when given an argument of , where A is an existing asso-
ciative array, will return true if the array has any set elements. Bash-5.2
will look for and report on a key named 

Parsing command substitutions will behave as if extended glob (see
Section 4.3.2 [The Shopt Builtin], page 71) is enabled, so that parsing a
command substitution containing an extglob pattern (say, as part of a
shell function) will not fail. This assumes the intent is to enable extglob
before the command is executed and word expansions are performed. It
will fail at word expansion time if extglob hasns terminal driver
and Bash.

The shell associates a job with each pipeline. It keeps a table of currently executing jobs,
which may be listed with the jobs command. When Bash starts a job asynchronously, it
prints a line that looks like:

[1] 25647

indicating that this job is job number 1 and that the process id of the last process in the
pipeline associated with this job is 25647. All of the processes in a single pipeline are
members of the same job. Bash uses the job abstraction as the basis for job control.

To facilitate the implementation of the user interface to job control, the operating system
maintains the notion of a current terminal process group id. Members of this process group
(processes whose process group id is equal to the current terminal process group id) receive
keyboard-generated signals such as SIGINT. These processes are said to be in the foreground.
Background processes are those whose process group id differs from the terminals terminal driver, which, unless caught,
suspends the process.

If the operating system on which Bash is running supports job control, Bash contains
facilities to use it. Typing the suspend character (typically , Control-Z) while a process
is running causes that process to be stopped and returns control to Bash. Typing the
delayed suspend character (typically , Control-Y) causes the process to be stopped
when it attempts to read input from the terminal, and control to be returned to Bash. The
user then manipulates the state of this job, using the bg command to continue it in the
background, the fg command to continue it in the foreground, or the kill command to
kill it. A  takes effect immediately, and has the additional side effect of causing pending
output and typeahead to be discarded.

There are a number of ways to refer to a job in the shell. The character  introduces

a job specification (jobspec).

Job number n may be referred to as . The symbols  and  refer to the shell%%-%+%-+-%cece%?cece%1fg %1%1 &bg %1s status so as to not interrupt
any other output. If the -b option to the set builtin is enabled, Bash reports such changes
immediately (see Section 4.3.1 [The Set Builtin], page 67). Any trap on SIGCHLD is executed
for each child process that exits.

If an attempt to exit Bash is made while jobs are stopped, (or running, if the checkjobs
option is enabled &s process group leader.

Display only running jobs.

Display only stopped jobs.

If jobspec is given, output is restricted to information about that job. If jobspec
is not supplied, the status of all jobs is listed.
If the -x option is supplied, jobs replaces any jobspec found in command or
arguments with the corresponding process group id, and executes command,
passing it arguments, returning its exit status.

kill [-s sigspec] [-n signum] [-sigspec] jobspec or pid
kill -l|-L [exit_status]

Send a signal specified by sigspec or signum to the process named by job specifi-
cation jobspec or process id pid. sigspec is either a case-insensitive signal name
such as SIGINT (with or without the SIG prefix) or a signal number; signum
is a signal number. If sigspec and signum are not present, SIGTERM is used.
The -l option lists the signal names. If any arguments are supplied when -l is
given, the names of the signals corresponding to the arguments are listed, and
the return status is zero. exit status is a number specifying a signal number or
the exit status of a process terminated by a signal. The -L option is equivalent
to -l. The return status is zero if at least one signal was successfully sent, or
non-zero if an error occurs or an invalid option is encountered.

wait [-fn] [-p varname] [jobspec or pid ...]

Wait until the child process specified by each process id pid or job specification
jobspec exits and return the exit status of the last command waited for. If a
job spec is given, all processes in the job are waited for. If no arguments are
given, wait waits for all running background jobs and the last-executed process
substitution, if its process id is the same as $!, and the return status is zero.
If the -n option is supplied, wait waits for a single job from the list of pids
or jobspecs or, if no arguments are supplied, any job, to complete and returns
its exit status. If none of the supplied arguments is a child of the shell, or if
no arguments are supplied and the shell has no unwaited-for children, the exit
status is 127. If the -p option is supplied, the process or job identifier of the
job for which the exit status is returned is assigned to the variable varname
named by the option argument. The variable will be unset initially, before any
assignment. This is useful only when the -n option is supplied. Supplying
the -f option, when job control is enabled, forces wait to wait for each pid or
jobspec to terminate before returning its status, instead of returning when it
changes status. If neither jobspec nor pid specifies an active child process of
the shell, the return status is 127. If wait is interrupted by a signal, the return
status will be greater than 128, as described above (see Section 3.7.6 [Signals],

Chapter 7: Job Control

116

disown

page 45). Otherwise, the return status is the exit status of the last process or
job waited for.

disown [-ar] [-h] [jobspec ... | pid ... ]

Without options, remove each jobspec from the table of active jobs. If the -h
option is given, the job is not removed from the table, but is marked so that
SIGHUP is not sent to the job if the shell receives a SIGHUP. If jobspec is not
present, and neither the -a nor the -r option is supplied, the current job is
used. If no jobspec is supplied, the -a option means to remove or mark all jobs;
the -r option without a jobspec argument restricts operation to running jobs.

suspend

suspend [-f]

Suspend the execution of this shell until it receives a SIGCONT signal. A login
shell, or a shell without job control enabled, cannot be suspended; the -f option
can be used to override this and force the suspension. The return status is 0
unless the shell is a login shell or job control is not enabled and -f is not
supplied.

When job control is not active, the kill and wait builtins do not accept jobspec argu-

ments. They must be supplied process ids.

7.3 Job Control Variables

auto_resume

This variable controls how the shell interacts with the user and job control. If
this variable exists then single word simple commands without redirections are
treated as candidates for resumption of an existing job. There is no ambiguity
allowed; if there is more than one job beginning with the string typed, then the
most recently accessed job will be selected. The name of a stopped job, in this
context, is the command line used to start it. If this variable is set to the value
, the string supplied must match the name of a stopped job exactly; if
set to , the string supplied needs to match a substring of the name
of a stopped job. The  value provides functionality analogous to
the  job id (see Section 7.1 [Job Control Basics], page 113). If set to any
other value, the supplied string must be a prefix of a stopped job%Control-KMeta-KMeta-Control-kpushed overpulled
backCutpastekillyankkillsM-- C-kdigit-M-1 0 C-d#$s terminfo description. A sample value
might be .

active-region-end-color

A string variable that "undoes" the effects of active-region-
start-color and restores "normal" terminal display appearance
after displaying text in the active region. This string must not take
up any physical character positions on the display, so it should con-
sist only of terminal escape sequences. It is output to the terminal
after displaying the text in the active region. This variable is re-
set to the default value whenever the terminal type changes. The
default value is the string that restores the terminal from stand-
out mode, as obtained from the terminal\e[0mnonevisibleaudibles
bell.

bell-style

bind-tty-special-chars

If set to  (the default), Readline attempts to bind the control
characters treated specially by the kernelonoffonreadline-colored-completion-prefixoffonoffonoffon-_offononoffOnoffononemacsvi\1\2@Ons standout mode. The active region shows
the text inserted by bracketed-paste and any matching text found
by incremental and non-incremental history searches. The default
is .

Chapter 8: Command Line Editing

124

enable-bracketed-paste

When set to , Readline configures the terminal to insert each
paste into the editing buffer as a single string of characters, instead
of treating each character as if it had been read from the keyboard.
This is called putting the terminal into bracketed paste mode; it
prevents Readline from executing any editing commands bound to
key sequences appearing in the pasted text. The default is .

enable-keypad

When set to , Readline will try to enable the application keypad
when it is called. Some systems need this to enable the arrow keys.
The default is .

enable-meta-key

When set to , Readline will try to enable any meta modifier
key the terminal claims to support when it is called. On many
terminals, the meta key is used to send eight-bit characters. The
default is .

expand-tilde

If set to , tilde expansion is performed when Readline attempts
word completion. The default is .

history-preserve-point

If set to , the history code attempts to place the point (the
current cursor position) at the same location on each history line
retrieved with previous-history or next-history. The default
is .

history-size

Set the maximum number of history entries saved in the history
list. If set to zero, any existing history entries are deleted and no
new entries are saved. If set to a value less than zero, the number
of history entries is not limited. By default, the number of history
entries is not limited. If an attempt is made to set history-size to
a non-numeric value, the maximum number of history entries will
be set to 500.

horizontal-scroll-mode

This variable can be set to either  or . Setting it to 
means that the text of the lines being edited will scroll horizontally
on a single screen line when they are longer than the width of the
screen, instead of wrapping onto a new screen line. This variable is
automatically set to  for terminals of height 1. By default, this
variable is set to .

input-meta

If set to , Readline will enable eight-bit input (it will not clear
the eighth bit in the characters it reads), regardless of what the
terminal claims it can support. The default value is , but
Readline will set it to  if the locale contains eight-bit characters.

Chapter 8: Command Line Editing

125

The name meta-flag is a synonym for this variable. This variable
is dependent on the LC_CTYPE locale category, and may change if
the locale is changed.

isearch-terminators

The string of characters that should terminate an incremental
search without subsequently executing the character as a command
(see Section 8.2.5 [Searching], page 119). If this variable has not
been given a value, the characters ESC and C-J will terminate an
incremental search.

keymap

emacs-ctlx,

Sets Readlineononon*offonoffon.off.ononoffonoffononononoffonoffonoffont share a common
prefix) cause the matches to be listed immediately instead of ring-
ing the bell. The default value is .

show-mode-in-prompt

If set to , add a string to the beginning of the prompt indicating
the editing mode: emacs, vi command, or vi insertion. The mode
strings are user-settable (e.g., emacs-mode-string). The default
value is .

Chapter 8: Command Line Editing

127

skip-completed-text

If set to , this alters the default completion behavior when in-
serting a single match into the line. IteMakefileMakefileMakefilefileoff\1\2(cmd)\1\2(ins)ons type is appended to the
filename when listing possible completions. The default is .

Key Bindings

The syntax for controlling key bindings in the init file is simple. First you
need to find the name of the command that you want to change. The following
sections contain tables of the command name, the default keybinding, if any,
and a short description of what the command does.
Once you know the name of the command, simply place on a line in the init
file the name of the key you wish to bind the command to, a colon, and then
the name of the command. There can be no space between the key name and
the colon >
outputC-x
C-rESC [ 1 1
~Function Key 1, a single quote or apostrophe

\". For
example, the following binding will make  insert a single  into the line:

"\C-x\\": "\\"

8.3.2 Conditional Init Constructs
Readline implements a facility similar in spirit to the conditional compilation features of
the C preprocessor which allows key bindings and variable settings to be performed as the
result of tests. There are four parser directives used.

$if

The $if construct allows bindings to be made based on the editing mode, the
terminal being used, or the application using Readline. The text of the test,
after any comparison operator, extends to the end of the line; unless otherwise
noted, no characters are required to isolate it.

mode

term

version

The mode= form of the $if directive is used to test whether Read-
line is in emacs or vi mode. This may be used in conjunction
with the  command, for instance, to set bindings in
the emacs-standard and emacs-ctlx keymaps only if Readline is
starting out in emacs mode.

The term= form may be used to include terminal-specific key bind-
ings, perhaps to bind the key sequences output by the terminal=-===!=<=>=<>7.10===!=#t strip characters to 7 bits when reading
set input-meta on

# allow iso-latin1 characters to be inserted rather
# than converted to prefix-meta sequences
set convert-meta off

# display characters with the eighth bit set directly
# rather than as meta-prefixed characters
set output-meta on

# if there are 150 or more possible completions for a word,
# ask whether or not the user wants to see all of them
set completion-query-items 150

Chapter 8: Command Line Editing

133

# For FTP
$if Ftp
"\C-xg": "get \M-?"
"\C-xt": "put \M-?"
"\M-.": yank-last-arg
$endif

8.4 Bindable Readline Commands

This section describes Readline commands that may be bound to key sequences. You can
list your key bindings by executing bind -P or, for a more terse format, suitable for an
inputrc file, bind -p. (See Section 4.2 [Bash Builtins], page 55.) Command names without
an accompanying key sequence are unbound by default.

In the following descriptions, point refers to the current cursor position, and mark refers
to a cursor position saved by the set-mark command. The text between the point and
mark is referred to as the region.

8.4.1 Commands For Moving

beginning-of-line (C-a)

Move to the start of the current line.

end-of-line (C-e)

Move to the end of the line.

forward-char (C-f)

Move forward a character.

backward-char (C-b)

Move back a character.

forward-word (M-f)

Move forward to the end of the next word. Words are composed of letters and
digits.

backward-word (M-b)

Move back to the start of the current or previous word. Words are composed
of letters and digits.

shell-forward-word (M-C-f)

Move forward to the end of the next word. Words are delimited by non-quoted
shell metacharacters.

shell-backward-word (M-C-b)

Move back to the start of the current or previous word. Words are delimited
by non-quoted shell metacharacters.

previous-screen-line ()

Attempt to move point to the same physical screen column on the previous
physical screen line. This will not have the desired effect if the current Readline
line does not take up more than one physical line or if point is not greater than
the length of the prompt plus the screen width.

Chapter 8: Command Line Editing

134

next-screen-line ()

Attempt to move point to the same physical screen column on the next physical
screen line. This will not have the desired effect if the current Readline line does
not take up more than one physical line or if the length of the current Readline
line is not greater than the length of the prompt plus the screen width.

clear-display (M-C-l)

Clear the screen and, if possible, the terminalbackforwardupdownupdown!n!$s standout mode to denote the
region.

transpose-chars (C-t)

Drag the character before the cursor forward over the character at the cursor,
moving the cursor forward as well. If the insertion point is at the end of the
line, then this transposes the last two characters of the line. Negative arguments
have no effect.

Chapter 8: Command Line Editing

137

transpose-words (M-t)

Drag the word before point past the word after point, moving point past that
word as well. If the insertion point is at the end of the line, this transposes the
last two words on the line.

upcase-word (M-u)

Uppercase the current (or following) word. With a negative argument, upper-
case the previous word, but do not move the cursor.

downcase-word (M-l)

Lowercase the current (or following) word. With a negative argument, lowercase
the previous word, but do not move the cursor.

capitalize-word (M-c)

Capitalize the current (or following) word. With a negative argument, capitalize
the previous word, but do not move the cursor.

overwrite-mode ()

Toggle overwrite mode. With an explicit positive numeric argument, switches
to overwrite mode. With an explicit non-positive numeric argument, switches to
insert mode. This command affects only emacs mode; vi mode does overwrite
differently. Each call to readline() starts in insert mode.
In overwrite mode, characters bound to self-insert replace the text at
point rather than pushing the text to the right. Characters bound to
backward-delete-char replace the character before point with a space.
By default, this command is unbound.

8.4.4 Killing And Yanking

kill-line (C-k)

Kill the text from point to the end of the line. With a negative numeric argu-
ment, kill backward from the cursor to the beginning of the current line.

backward-kill-line (C-x Rubout)

Kill backward from the cursor to the beginning of the current line. With a
negative numeric argument, kill forward from the cursor to the end of the
current line.

unix-line-discard (C-u)

Kill backward from the cursor to the beginning of the current line.

kill-whole-line ()

Kill all characters on the current line, no matter where point is. By default,
this is unbound.

kill-word (M-d)

Kill from point to the end of the current word, or if between words, to the end
of the next word. Word boundaries are the same as forward-word.

backward-kill-word (M-DEL)

Kill the word behind point. Word boundaries are the same as backward-word.

Chapter 8: Command Line Editing

138

shell-kill-word (M-C-d)

Kill from point to the end of the current word, or if between words, to the end
of the next word. Word boundaries are the same as shell-forward-word.

shell-backward-kill-word ()

Kill the word behind point. Word boundaries are the same as shell-backward-
word.

shell-transpose-words (M-C-t)

Drag the word before point past the word after point, moving point past that
word as well. If the insertion point is at the end of the line, this transposes the
last two words on the line. Word boundaries are the same as shell-forward-
word and shell-backward-word.

unix-word-rubout (C-w)

Kill the word behind point, using white space as a word boundary. The killed
text is saved on the kill-ring.

unix-filename-rubout ()

Kill the word behind point, using white space and the slash character as the
word boundaries. The killed text is saved on the kill-ring.

delete-horizontal-space ()

Delete all spaces and tabs around point. By default, this is unbound.

kill-region ()

Kill the text in the current region. By default, this command is unbound.

copy-region-as-kill ()

Copy the text in the region to the kill buffer, so it can be yanked right away.
By default, this command is unbound.

copy-backward-word ()

Copy the word before point to the kill buffer. The word boundaries are the
same as backward-word. By default, this command is unbound.

copy-forward-word ()

Copy the word following point to the kill buffer. The word boundaries are the
same as forward-word. By default, this command is unbound.

yank (C-y)

Yank the top of the kill ring into the buffer at point.

yank-pop (M-y)

Rotate the kill-ring, and yank the new top. You can only do this if the prior
command is yank or yank-pop.

8.4.5 Specifying Numeric Arguments

digit-argument (M-0, M-1, ... M--)

Add this digit to the argument already accumulating, or start a new argument.
M-- starts a negative argument.

Chapter 8: Command Line Editing

139

universal-argument ()

This is another way to specify an argument. If this command is followed by one
or more digits, optionally with a leading minus sign, those digits define the ar-
gument. If the command is followed by digits, executing universal-argument
again ends the numeric argument, but is otherwise ignored. As a special case,
if this command is immediately followed by a character that is neither a digit
nor minus sign, the argument count for the next command is multiplied by
four. The argument count is initially one, so executing this function the first
time makes the argument count four, a second time makes the argument count
sixteen, and so on. By default, this is not bound to a key.

8.4.6 Letting Readline Type For You

complete (TAB)

Attempt to perform completion on the text before point. The actual completion
performed is application-specific. Bash attempts completion treating the text
as a variable (if the text begins with ), username (if the text begins with
), hostname (if the text begins with ), or command (including aliases and
functions) in turn. If none of these produces a match, filename completion is
attempted.

possible-completions (M-?)

List the possible completions of the text before point. When displaying com-
pletions, Readline sets the number of columns used for display to the value of
completion-display-width, the value of the environment variable COLUMNS,
or the screen width, in that order.

insert-completions (M-*)

Insert all completions of the text before point that would have been generated
by possible-completions.

menu-complete ()

Similar to complete, but replaces the word to be completed with a single match
from the list of possible completions. Repeated execution of menu-complete
steps through the list of possible completions, inserting each match in turn.
At the end of the list of completions, the bell is rung (subject to the setting
of bell-style) and the original text is restored. An argument of n moves n
positions forward in the list of matches; a negative argument may be used to
move backward through the list. This command is intended to be bound to
TAB, but is unbound by default.

menu-complete-backward ()

Identical to menu-complete, but moves backward through the list of possible
completions, as if menu-complete had been given a negative argument.

delete-char-or-list ()

Deletes the character under the cursor if not at the beginning or end of the
line (like delete-char).
If at the end of the line, behaves identically to
possible-completions. This command is unbound by default.

complete-filename (M-/)

Attempt filename completion on the text before point.

Chapter 8: Command Line Editing

140

possible-filename-completions (C-x /)

List the possible completions of the text before point, treating it as a filename.

complete-username (M-~)

Attempt completion on the text before point, treating it as a username.

possible-username-completions (C-x ~)

List the possible completions of the text before point, treating it as a username.

complete-variable (M-$)

Attempt completion on the text before point, treating it as a shell variable.

possible-variable-completions (C-x $)

List the possible completions of the text before point, treating it as a shell
variable.

complete-hostname (M-@)

Attempt completion on the text before point, treating it as a hostname.

possible-hostname-completions (C-x @)

List the possible completions of the text before point, treating it as a hostname.

complete-command (M-!)

Attempt completion on the text before point, treating it as a command name.
Command completion attempts to match the text against aliases, reserved
words, shell functions, shell builtins, and finally executable filenames, in that
order.

possible-command-completions (C-x !)

List the possible completions of the text before point, treating it as a command
name.

dynamic-complete-history (M-TAB)

Attempt completion on the text before point, comparing the text against lines
from the history list for possible completion matches.

dabbrev-expand ()

Attempt menu completion on the text before point, comparing the text against
lines from the history list for possible completion matches.

complete-into-braces (M-{)

Perform filename completion and insert the list of possible completions enclosed
within braces so the list is available to the shell (see Section 3.5.1 [Brace Ex-
pansion], page 24).

8.4.7 Keyboard Macros

start-kbd-macro (C-x ()

Begin saving the characters typed into the current keyboard macro.

end-kbd-macro (C-x ))

Stop saving the characters typed into the current keyboard macro and save the
definition.

Chapter 8: Command Line Editing

141

call-last-kbd-macro (C-x e)

Re-execute the last keyboard macro defined, by making the characters in the
macro appear as if typed at the keyboard.

print-last-kbd-macro ()

Print the last keyboard macro defined in a format suitable for the inputrc file.

8.4.8 Some Miscellaneous Commands

re-read-init-file (C-x C-r)

Read in the contents of the inputrc file, and incorporate any bindings or variable
assignments found there.

abort (C-g)

Abort the current editing command and ring the terminalESC f**set -o
emacsset -o viinsertionicommandkj&&!s default completion will be performed
if the compspec (and, if attempted, the default Bash completions) generate no matches.

When a compspec indicates that directory name completion is desired, the programmable
completion functions force Readline to append a slash to completed names which are sym-
bolic links to directories, subject to the value of the mark-directories Readline variable,
regardless of the setting of the mark-symlinked-directories Readline variable.

There is some support for dynamically modifying completions. This is most useful when
used in combination with a default completion specified with -D.
Itdefaultempty;|s behav-
ior beyond the simple generation of completions. comp-option may
be one of:

bashdefault

Perform the rest of the default Bash completions if the
compspec generates no matches.

default

Use Readline!defaultempty;| compgen prints the possible completions it generates one per
line.

Possible completions go into the COMPREPLY array variable, one completion per array
element. The programmable completion system retrieves the completions from there when
the function returns.

# A completion function for the cd builtin
# based on the cd completion function from the bash_completion package
_comp_cd()
{

local IFS=$
local cur _skipdot _cdpath
local i j k

# normalize IFS

# Tilde expansion, which also expands tilde to full pathname
case "$2" in
\~*)
*)
esac

eval cur="$2" ;;
cur=$2 ;;

# no cdpath or absolute pathname -- straight directory completion
if [[ -z "${CDPATH:-}" ]] || [[ "$cur" == @(./*|../*|/*) ]]; then

# compgen prints paths one per line; could also use while loop
IFS=$
COMPREPLY=( $(compgen -d -- "$cur") )
IFS=$

# CDPATH+directories in the current directory if not in CDPATH
else

IFS=$
_skipdot=false
# preprocess CDPATH to convert null directory names to .
_cdpath=${CDPATH/#:/.:}

Chapter 8: Command Line Editing

151

_cdpath=${_cdpath//::/:.:}
_cdpath=${_cdpath/%:/:.}
for i in ${_cdpath//:/$}; do

if [[ $i -ef . ]]; then _skipdot=true; fi
k="${#COMPREPLY[@]}"
for j in $( compgen -d -- "$i/$cur" ); do

COMPREPLY[k++]=${j#$i/}

# cut off directory

done

done
$_skipdot || COMPREPLY+=( $(compgen -d -- "$cur") )
IFS=$

fi

# variable names if appropriate shell option set and no completions
if shopt -q cdable_vars && [[ ${#COMPREPLY[@]} -eq 0 ]]; then

COMPREPLY=( $(compgen -v -- "$cur") )

fi

return 0

}

We install the completion function using the -F option to complete:

# Tell readline to quote appropriate and append slashes to directories;
# use the bash default completion for other arguments
complete -o filenames -o nospace -o bashdefault -F _comp_cd cd

Since were using directories found via CDPATH : Readline can possible completions that Bash adds to the default
Readline set. These include things like command name completion, variable completion for
words beginning with  or , completions containing pathname expansion patterns (see
Section 3.5.8 [Filename Expansion], page 35), and so on.

Once installed using complete, _comp_cd will be called every time we attempt word

completion for a cd command.

Many more examples are available as part of the bash completion project.
This is installed by default on many GNU/Linux distributions. Originally written by Ian
Macdonald, the project now lives at https: / / github . com / scop / bash-completion / .
There are ports for other systems such as Solaris and Mac OS X.

An older version of the bash completion package is distributed with bash in the

examples/complete subdirectory.

152

9 Using History Interactively

This chapter describes how to use the gnu History Library interactively, from a users guide. For information on using the gnu
standpoint.
History Library in other programs, see the gnu Readline Library Manual.

9.1 Bash History Facilities

When the -o history option to the set builtin is enabled (see Section 4.3.1 [The Set
Builtin], page 67), the shell provides access to the command history, the list of commands
previously typed. The value of the HISTSIZE shell variable is used as the number of com-
mands to save in a history list. The text of the last $HISTSIZE commands (default 500)
is saved. The shell stores each command in the history list prior to parameter and vari-
able expansion but after history expansion is performed, subject to the values of the shell
variables HISTIGNORE and HISTCONTROL.

When the shell starts up, the history is initialized from the file named by the HISTFILE
variable (default ~/.bash_history). The file named by the value of HISTFILE is truncated,
if necessary, to contain no more than the number of lines specified by the value of the
HISTFILESIZE variable. When a shell with history enabled exits, the last $HISTSIZE lines
are copied from the history list to the file named by $HISTFILE. If the histappend shell
option is set (see Section 4.2 [Bash Builtins], page 55), the lines are appended to the history
file, otherwise the history file is overwritten. If HISTFILE is unset, or if the history file is
unwritable, the history is not saved. After saving the history, the history file is truncated
to contain no more than $HISTFILESIZE lines. If HISTFILESIZE is unset, or set to null, a
non-numeric value, or a numeric value less than zero, the history file is not truncated.

If the HISTTIMEFORMAT is set, the time stamp information associated with each history
entry is written to the history file, marked with the history comment character. When the
history file is read, lines beginning with the history comment character followed immediately
by a digit are interpreted as timestamps for the following history entry.

The builtin command fc may be used to list or edit and re-execute a portion of the history
list. The history builtin may be used to display or modify the history list and manipulate
the history file. When using command-line editing, search commands are available in each
editing mode that provide access to the history list (see Section 8.4.2 [Commands For
History], page 134).

The shell allows control over which commands are saved on the history list. The
HISTCONTROL and HISTIGNORE variables may be set to cause the shell to save only a subset
of the commands entered. The cmdhist shell option, if enabled, causes the shell to attempt
to save each line of a multi-line command in the same history entry, adding semicolons where
necessary to preserve syntactic correctness. The lithist shell option causes the shell to
save the command with embedded newlines instead of semicolons. The shopt builtin is
used to set these options. See Section 4.3.2 [The Shopt Builtin], page 71, for a description
of shopt.

9.2 Bash History Builtins

Bash provides two builtin commands which manipulate the history list and history file.

Chapter 9: Using History Interactively

153

fc

fc [-e ename] [-lnr] [first] [last]
fc -s [pat=rep] [command]

The first form selects a range of commands from first to last from the history
list and displays or edits and re-executes them. Both first and last may be
specified as a string (to locate the most recent command beginning with that
string) or as a number (an index into the history list, where a negative number
is used as an offset from the current command number).
When listing, a first or last of 0 is equivalent to -1 and -0 is equivalent to the
current command (usually the fc command); otherwise 0 is equivalent to -1
and -0 is invalid.
If last is not specified, it is set to first. If first is not specified, it is set to the
previous command for editing and fc -sr ccr*-1!\ may be used to escape the history expansion
character, but the history expansion character is also treated as quoted if it immediately
precedes the closing double quote in a double-quoted string.

Several shell options settable with the shopt builtin (see Section 4.3.2 [The Shopt
Builtin], page 71) may be used to tailor the behavior of history expansion. If the histverify
shell option is enabled, and Readline is being used, history substitutions are not immedi-
ately passed to the shell parser. Instead, the expanded line is reloaded into the Readline
editing buffer for further modification. If Readline is being used, and the histreedit shell
option is enabled, a failed history expansion will be reloaded into the Readline editing buffer
for correction. The -p option to the history builtin command may be used to see what a
history expansion will do before using it. The -s option to the history builtin may be used
to add commands to the end of the history list without actually executing them, so that
they are available for subsequent recall. This is most useful in conjunction with Readline.

The shell allows control of the various characters used by the history expansion mech-
anism with the histchars variable, as explained above (see Section 5.2 [Bash Variables],
page 78). The shell uses the history comment character to mark history timestamps when
writing the history file.

9.3.1 Event Designators
An event designator is a reference to a command line entry in the history list. Unless the
reference is absolute, events are relative to the current position in the history list.

!

!n

!-n

!!

Start a history substitution, except when followed by a space, tab, the end of
the line,  or  (when the extglob shell option is enabled using the shopt
builtin).

Refer to command line n.

Refer to the command n lines back.

Refer to the previous command. This is a synonym for .

!string

Refer to the most recent command preceding the current position in the history
list starting with string.

!?string[?]

Refer to the most recent command preceding the current position in the history
list containing string. The trailing  may be omitted if the string is followed
immediately by a newline. If string is missing, the string from the most recent
search is used; it is an error if there is no previous search string.

Chapter 9: Using History Interactively

156

^string1^string2^

Quick Substitution. Repeat the last command, replacing string1 with string2.
Equivalent to !!:s^string1^string2^.

!#

The entire command line typed so far.

9.3.2 Word Designators
Word designators are used to select desired words from the event. A  separates the event
specification from the word designator. It may be omitted if the word designator begins
with a , , , , or . Words are numbered from the beginning of the line, with the
first word being denoted by 0 (zero). Words are inserted into the current line separated by
single spaces.

For example,

!!

!!:$

!fi:2

designates the preceding command. When you type this, the preceding com-
mand is repeated in toto.

designates the last argument of the preceding command. This may be shortened
to !$.

designates the second argument of the most recent command starting with the
letters fi.

Here are the word designators:

0 (zero) The 0th word. For many applications, this is the command word.

n

^

$

%

x-y

*

x*

x-

The nth word.

The first argument; that is, word 1.

The last argument.

The first word matched by the most recent  search, if the search
string begins with a character that is part of a word.

A range of words;  abbreviates .

All of the words, except the 0th. This is a synonym for . It is not an error
to use  if there is just one word in the event; the empty string is returned in
that case.

Abbreviates 

Abbreviates  like , but omits the last word. If  is missing, it defaults
to 0.

If a word designator is supplied without an event specification, the previous command

is used as the event.

9.3.3 Modifiers
After the optional word designator, you can add a sequence of one or more of the following
modifiers, each preceded by a . These modify, or edit, the word or words selected from
the history event.

h

Remove a trailing pathname component, leaving only the head.

Chapter 9: Using History Interactively

157

t

r

e

p

q

x

Remove all leading pathname components, leaving the tail.

Remove a trailing suffix of the form , leaving the basename.

Remove all but the trailing suffix.

Print the new command but do not execute it.

Quote the substituted words, escaping further substitutions.

Quote the substituted words as with , but break into words at spaces, tabs,
and newlines. The  and  modifiers are mutually exclusive; the last one
supplied is used.

s/old/new/

Substitute new for the first occurrence of old in the event line. Any character
may be used as the delimiter in place of . The delimiter may be quoted in
old and new with a single backslash. If  appears in new, it is replaced by
old. A single backslash will quote the . If old is null, it is set to the last old
substituted, or, if no previous history substitutions took place, the last string
in a !?string[?] search. If new is null, each matching old is deleted. The final
delimiter is optional if it is the last character on the input line.

Repeat the previous substitution.

Cause changes to be applied over the entire event line. Used in conjunction
with , as in gs/old/new/, or with .

Apply the following  or  modifier once to each word in the event.

&

g
a

G

158

10 Installing Bash

This chapter provides basic instructions for installing Bash on the various supported plat-
forms. The distribution supports the gnu operating systems, nearly every version of Unix,
and several non-Unix systems such as BeOS and Interix. Other independent ports exist for
ms-dos, os/2, and Windows platforms.

10.1 Basic Installation

These are installation instructions for Bash.

The simplest way to compile Bash is:

1. cd to the directory containing the source code and type  to configure
Bash for your system. If yoush ./configuremakemake testsmake installsudo make installt want to keep, you may remove or edit it.

To find out more about the options and arguments that the configure script under-

stands, type

bash-4.2$ ./configure --help

at the Bash prompt in your Bash source directory.

If you want to build Bash in a directory separate from the source directory just use the full path to the configure script. The
following commands will build bash in a directory under /usr/local/build from the source
code in /usr/local/src/bash-4.4:

mkdir /usr/local/build/bash-4.4

Chapter 10: Installing Bash

159

cd /usr/local/build/bash-4.4
bash /usr/local/src/bash-4.4/configure
make

See Section 10.3 [Compiling For Multiple Architectures], page 159, for more information

about building in a directory separate from the source.

If you need to do unusual things to compile Bash, please try to figure out how
configure could check whether or not to do them, and mail diffs or instructions to
bash-maintainers@gnu.org so they can be considered for the next release.

The file configure.ac is used to create configure by a program called Autoconf. You
only need configure.ac if you want to change it or regenerate configure using a newer
version of Autoconf. If you do this, make sure you are using Autoconf version 2.69 or newer.
You can remove the program binaries and object files from the source code directory by
typing . To also remove the files that configure created (so you can compile
Bash for a different kind of computer), type .

10.2 Compilers and Options

Some systems require unusual options for compilation or linking that the configure script
does not know about. You can give configure initial values for variables by setting them
in the environment. Using a Bourne-compatible shell, you can do that on the command
line like this:

CC=c89 CFLAGS=-O2 LIBS=-lposix ./configure

On systems that have the env program, you can do it like this:

env CPPFLAGS=-I/usr/local/include LDFLAGS=-s ./configure

The configuration process uses GCC to build Bash if it is available.

10.3 Compiling For Multiple Architectures

You can compile Bash for more than one kind of computer at the same time, by placing the
object files for each architecture in their own directory. To do this, you must use a version
of make that supports the VPATH variable, such as GNU make. cd to the directory where
you want the object files and executables to go and run the configure script from the
source directory (see Section 10.1 [Basic Installation], page 158). You may need to supply
the --srcdir=PATH argument to tell configure where the source files are. configure
automatically checks for the source code in the directory that configure is in and in .

If you have to use a make that does not support the VPATH variable, you can compile Bash
for one architecture at a time in the source code directory. After you have installed Bash
for one architecture, use  before reconfiguring for another architecture.

Alternatively, if your system supports symbolic links, you can use the support/mkclone
script to create a build tree which has symbolic links back to each file in the source directory.
Heremake installmakemake installmake install
prefix=PATHmake installmake install exec_prefix=/d like to use as the root of your sample
installation tree. For example,

mkdir /fs1/bash-install
make install DESTDIR=/fs1/bash-install

will install bash into /fs1/bash-install/usr/local/bin/bash, the documentation into
directories within /fs1/bash-install/usr/local/share, the example loadable builtins
into /fs1/bash-install/usr/local/lib/bash, and so on. You can use the usual exec_
prefix and prefix variables to alter the directory paths beneath the value of DESTDIR.

The GNU Makefile standards provide a more complete description of these variables and

their effects.

10.5 Specifying the System Type

There may be some features configure can not figure out automatically, but needs to
determine by the type of host Bash will run on. Usually configure can figure that out, but
if it prints a message saying it can not guess the host type, give it the --host=TYPE option.
can either be a short name for the system type, such as , or a canonical name
with three fields:  (e.g., ).

See the file support/config.sub for the possible values of each field.

10.6 Sharing Defaults

If you want to set default values for configure scripts to share, you can create a site
shell script called config.site that gives default values for variables like CC, cache_
file, and prefix. configure looks for PREFIX/share/config.site if it exists, then
PREFIX/etc/config.site if it exists. Or, you can set the CONFIG_SITE environment vari-
able to the location of the site script. A warning: the Bash configure looks for a site
script, but not all configure scripts do.

Chapter 10: Installing Bash

161

10.7 Operation Controls

configure recognizes the following options to control how it operates.

--cache-file=file

Use and save the results of the tests in file instead of ./config.cache. Set file
to /dev/null to disable caching, for debugging configure.

--help

Print a summary of the options to configure, and exit.

--quiet
--silent
-q

Do not print messages saying which checks are being made.

--srcdir=dir

Look for the Bash source code in directory dir. Usually configure can deter-
mine that directory automatically.

--version

Print the version of Autoconf used to generate the configure script, and exit.

configure also accepts some other, not widely used, boilerplate options.

prints the complete list.

10.8 Optional Features

The Bash configure has a number of --enable-feature options, where feature indicates
an optional part of Bash. There are also several --with-package options, where package
is something like  or . To turn off the default use of a package, use
--without-package. To configure Bash without a feature that is enabled by default, use
--disable-feature.

Here is a complete list of the --enable- and --with- options that the Bash configure

recognizes.

--with-afs

Define if you are using the Andrew File System from Transarc.

--with-bash-malloc

Use the Bash version of malloc in the directory lib/malloc. This is not the
same malloc that appears in gnu libc, but an older version originally derived
from the 4.2 bsd malloc. This malloc is very fast, but wastes some space on
each allocation. This option is enabled by default. The NOTES file contains a
list of systems for which this should be turned off, and configure disables this
option automatically for a number of systems.

--with-curses

Use the curses library instead of the termcap library. This should be supplied
if your system has an inadequate or incomplete termcap database.

--with-gnu-malloc

A synonym for --with-bash-malloc.

--with-installed-readline[=PREFIX]

Define this to make Bash link with a locally-installed version of Readline rather
than the version in lib/readline. This works only with Readline 5.0 and later

Chapter 10: Installing Bash

162

versions. If PREFIX is yes or not supplied, configure uses the values of the
make variables includedir and libdir, which are subdirectories of prefix by
default, to find the installed version of Readline if it is not in the standard
system include and library directories. If PREFIX is no, Bash links with the
version in lib/readline.
If PREFIX is set to any other value, configure
treats it as a directory pathname and looks for the installed version of Readline
in subdirectories of that directory (include files in PREFIX/include and the
library in PREFIX/lib).

--with-libintl-prefix[=PREFIX]

Define this to make Bash link with a locally-installed version of the libintl
library instead of the version in lib/intl.

--with-libiconv-prefix[=PREFIX]

Define this to make Bash look for libiconv in PREFIX instead of the standard
system locations. There is no version included with Bash.

--enable-minimal-config

This produces a shell with minimal features, close to the historical Bourne shell.

There are several --enable- options that alter how Bash is compiled, linked, and in-

stalled, rather than changing run-time features.

--enable-largefile

Enable support for large files (http://www.unix.org/version2/whatsnew/
lfs20mar.html) if the operating system requires special compiler options to
build programs which can access large files. This is enabled by default, if the
operating system provides large file support.

--enable-profiling

This builds a Bash binary that produces profiling information to be processed
by gprof each time it is executed.

--enable-separate-helpfiles

Use external files for the documentation displayed by the help builtin instead
of storing the text internally.

--enable-static-link

This causes Bash to be linked statically, if gcc is being used. This could be
used to build a version to use as rootminimal-configenable-featurealt-array-implementationdisabled-builtinsxpg-echo-defaultdirexpand-defaultstrict-posix-default bac bbc ). See Section 3.5.1
[Brace Expansion], page 24, for a complete description.

--enable-casemod-attributes

Include support for case-modifying attributes in the declare builtin and as-
signment statements. Variables with the uppercase attribute, for example,
will have their values converted to uppercase upon assignment.

--enable-casemod-expansion

Include support for case-modifying word expansions.

--enable-command-timing

Include support for recognizing time as a reserved word and for displaying
timing statistics for the pipeline following time (see Section 3.2.3 [Pipelines],
page 10). This allows pipelines as well as shell builtins and functions to be
timed.

--enable-cond-command

Include support for the [[ conditional command. (see Section 3.2.5.2 [Condi-
tional Constructs], page 12).

--enable-cond-regexp

Include support for matching posix regular expressions using the  binary
operator in the [[ conditional command. (see Section 3.2.5.2 [Conditional Con-
structs], page 12).

--enable-coprocesses

Include support for coprocesses and the coproc reserved word (see Section 3.2.3
[Pipelines], page 10).

--enable-debugger

Include support for the bash debugger (distributed separately).

--enable-dev-fd-stat-broken

If calling stat on /dev/fd/N returns different results than calling fstat on file
descriptor N, supply this option to enable a workaround. This has implications
for conditional commands that test file attributes.

Chapter 10: Installing Bash

164

--enable-direxpand-default

Cause the direxpand shell option (see Section 4.3.2 [The Shopt Builtin],
page 71) to be enabled by default when the shell starts. It is normally disabled
by default.

--enable-directory-stack

Include support for a csh-like directory stack and the pushd, popd, and dirs
builtins (see Section 6.8 [The Directory Stack], page 102).

--enable-disabled-builtins

Allow builtin commands to be invoked via  even after xxx has
been disabled using . See Section 4.2 [Bash Builtins], page 55,
for details of the builtin and enable builtin commands.

--enable-dparen-arithmetic

Include support for the ((...)) command (see Section 3.2.5.2 [Conditional
Constructs], page 12).

--enable-extended-glob

Include support for the extended pattern matching features described above
under Section 3.5.8.1 [Pattern Matching], page 36.

--enable-extended-glob-default

Set the default value of the extglob shell option described above under
Section 4.3.2 [The Shopt Builtin], page 71, to be enabled.

--enable-function-import

Include support for importing function definitions exported by another instance
of the shell from the environment. This option is enabled by default.

--enable-glob-asciirange-default

Set the default value of the globasciiranges shell option described above un-
der Section 4.3.2 [The Shopt Builtin], page 71, to be enabled. This controls the
behavior of character ranges when used in pattern matching bracket expres-
sions.

--enable-help-builtin

Include the help builtin, which displays help on shell builtins and variables (see
Section 4.2 [Bash Builtins], page 55).

--enable-history

Include command history and the fc and history builtin commands (see
Section 9.1 [Bash History Facilities], page 152).

--enable-job-control

This enables the job control features (see Chapter 7 [Job Control], page 113),
if the operating system supports them.

--enable-multibyte

This enables support for multibyte characters if the operating system provides
the necessary support.

Chapter 10: Installing Bash

165

--enable-net-redirections

This enables the special handling of filenames of the form /dev/tcp/host/port
and /dev/udp/host/port when used in redirections (see Section 3.6 [Redirec-
tions], page 38).

--enable-process-substitution

This enables process substitution (see Section 3.5.6 [Process Substitution],
page 34) if the operating system provides the necessary support.

--enable-progcomp

Enable the programmable completion facilities (see Section 8.6 [Programmable
Completion], page 143). If Readline is not enabled, this option has no effect.

--enable-prompt-string-decoding

Turn on the interpretation of a number of backslash-escaped characters in the
$PS0, $PS1, $PS2, and $PS4 prompt strings. See Section 6.9 [Controlling the
Prompt], page 104, for a complete list of prompt string escape sequences.

--enable-readline

Include support for command-line editing and history with the Bash version of
the Readline library (see Chapter 8 [Command Line Editing], page 117).

--enable-restricted

Include support for a restricted shell.
If this is enabled, Bash, when called
as rbash, enters a restricted mode. See Section 6.10 [The Restricted Shell],
page 105, for a description of restricted mode.

--enable-select

Include the select compound command, which allows the generation of simple
menus (see Section 3.2.5.2 [Conditional Constructs], page 12).

--enable-single-help-strings

Store the text displayed by the help builtin as a single string for each help
topic. This aids in translating the text to different languages. You may need
to disable this if your compiler cannot handle very long string literals.

--enable-strict-posix-default

Make Bash posix-conformant by default (see Section 6.11 [Bash POSIX Mode],
page 106).

--enable-translatable-strings

Enable support for $"string" translatable strings (see Section 3.1.2.5 [Locale
Translation], page 7).

--enable-usg-echo-default

A synonym for --enable-xpg-echo-default.

--enable-xpg-echo-default

Make the echo builtin expand backslash-escaped characters by default, without
requiring the -e option. This sets the default value of the xpg_echo shell option
to on, which makes the Bash echo behave more like the version specified in the
Single Unix Specification, version 3. See Section 4.2 [Bash Builtins], page 55,
for a description of the escape sequences that echo recognizes.

Chapter 10: Installing Bash

166

The file config-top.h contains C Preprocessor  statements for options which
are not settable from configure. Some of these are not meant to be changed; beware of
the consequences if you do. Read the comments associated with each definition for more
information about its effect.

167

Appendix A Reporting Bugs

Please report all bugs you find in Bash. But first, you should make sure that it really is a
bug, and that it appears in the latest version of Bash. The latest version of Bash is always
available for FTP from ftp://ftp.gnu.org/pub/gnu/bash/ and from http://git.
savannah.gnu.org/cgit/bash.git/snapshot/bash-master.tar.gz.

Once you have determined that a bug actually exists, use the bashbug command to
submit a bug report. If you have a fix, you are encouraged to mail that as well! Suggestions
and  bug reports may be mailed to bug-bash@gnu.org or posted to the Usenet
newsgroup gnu.bash.bug.

All bug reports should include:
The hardware and operating system.
A description of the bug behaviour.
recipe Bash is posix-conformant, even where the posix specification differs from traditional

sh behavior (see Section 6.11 [Bash POSIX Mode], page 106).

Bash has command-line editing (see Chapter 8 [Command Line Editing], page 117)

and the bind builtin.

Bash has command history (see Section 9.1 [Bash History Facilities], page 152) and the
history and fc builtins to manipulate it. The Bash history list maintains timestamp
information and uses the value of the HISTTIMEFORMAT variable to display it.

Bash has one-dimensional array variables (see Section 6.7 [Arrays], page 100), and the
appropriate variable expansions and assignment syntax to use them. Several of the
Bash builtins take options to act on arrays. Bash provides a number of built-in array
variables.

... Bash supports the $"..." quoting syntax to do locale-specific translation of the char-
acters between the double quotes. The -D, --dump-strings, and --dump-po-strings
invocation options list the translatable strings found in a script (see Section 3.1.2.5
[Locale Translation], page 7).

-o pipefail Bash has the time reserved word and command timing (see Section 3.2.3 [Pipelines],
page 10). The display of the timing statistics may be controlled with the TIMEFORMAT
variable.

Bash includes the select compound command, which allows the generation of simple

menus (see Section 3.2.5.2 [Conditional Constructs], page 12).

Appendix B: Major Differences From The Bourne Shell

169

Bash provides optional case-insensitive matching for the case and [[ constructs.
Bash implements command aliases and the alias and unalias builtins (see Section 6.6

[Aliases], page 100).

Variables present in the shell Bash supports the  assignment operator, which appends to the value of the variable

named on the left hand side.

%#%%## The expansion ${#xx}, which returns the length of ${xx},

is supported (see

Section 3.5.3 [Shell Parameter Expansion], page 26).

s value
of length length, beginning at offset, is present (see Section 3.5.3 [Shell Parameter
Expansion], page 26).

The expansion ${!prefix*} expansion, which expands to the names of all shell vari-
ables whose names begin with prefix, is available (see Section 3.5.3 [Shell Parameter
Expansion], page 26).

Bash can expand positional parameters beyond $9 using ${num}.
s  (which is also
implemented for backwards compatibility).

Bash automatically assigns variables that provide information about the current
user (UID, EUID, and GROUPS), the current host (HOSTTYPE, OSTYPE, MACHTYPE, and
HOSTNAME), and the instance of Bash that is running (BASH, BASH_VERSION, and
BASH_VERSINFO). See Section 5.2 [Bash Variables], page 78, for details.

The filename expansion bracket expression code uses  and  to negate the set of

characters between the brackets. The Bourne shell uses only .

Bash implements extended pattern matching features when the extglob shell option

is enabled (see Section 3.5.8.1 [Pattern Matching], page 36).

Bash functions are permitted to have local variables using the local builtin, and thus
useful recursive functions may be written (see Section 4.2 [Bash Builtins], page 55).
Bash performs filename expansion on filenames specified as operands to input and

output redirection operators (see Section 3.6 [Redirections], page 38).

<>&> Bash includes the  redirection operator, allowing a string to be used as the standard

input to a command.

[n]<&word[n]>&word Bash treats a number of filenames specially when they are used in redirection operators

(see Section 3.6 [Redirections], page 38).

The noclobber option is available to avoid overwriting existing files with output redi-
rection (see Section 4.3.1 [The Set Builtin], page 67). The  redirection operator
may be used to override noclobber.

Bash allows a function to override a builtin with the same name, and provides access to
that builtin The command builtin allows selective disabling of functions when command lookup is

performed (see Section 4.2 [Bash Builtins], page 55).

The Bash exec builtin takes additional options that allow users to control the contents
of the environment passed to the executed command, and what the zeroth argument
to the command is to be (see Section 4.1 [Bourne Shell Builtins], page 48).

The Bash export, readonly, and declare builtins can take a -f option to act on
shell functions, a -p option to display variables with various attributes set in a format
that can be used as shell input, a -n option to remove various variable attributes, and
arguments to set variable attributes and values simultaneously.

hash -p Bash includes a help builtin for quick reference to shell facilities (see Section 4.2 [Bash

Builtins], page 55).

The Bash read builtin (see Section 4.2 [Bash Builtins], page 55) will read a line ending
in  with the -r option, and will use the REPLY variable as a default if no non-option
arguments are supplied. The Bash read builtin also accepts a prompt string with the
-p option and will use Readline to obtain the line when given the -e option. The read
builtin also has additional options to control input: the -s option will turn off echoing
of input characters as they are read, the -t option will allow read to time out if input
does not arrive within a specified number of seconds, the -n option will allow reading
only a specified number of characters rather than a full line, and the -d option will
read until a particular character rather than newline.

Bash includes the shopt builtin, for finer control of shell optional capabilities (see
Section 4.3.2 [The Shopt Builtin], page 71), and allows these options to be set and
unset at shell invocation (see Section 6.1 [Invoking Bash], page 91).

The  (xtrace) option displays commands other than simple commands when per-

forming an execution trace (see Section 4.3.1 [The Set Builtin], page 67).

Bash includes the caller builtin, which displays the context of any active subroutine
call (a shell function or a script executed with the . or source builtins). This supports
the Bash debugger.

The Bash type builtin is more extensive and gives more information about the names

it finds (see Section 4.2 [Bash Builtins], page 55).

Bash implements a csh-like directory stack, and provides the pushd, popd, and dirs
builtins to manipulate it (see Section 6.8 [The Directory Stack], page 102). Bash also
makes the directory stack visible as the value of the DIRSTACK shell variable.

The Bash restricted mode is more useful (see Section 6.10 [The Restricted Shell],

page 105); the SVR4.2 shell restricted mode is too limited.

Bash includes a number of features to support a separate debugger for shell scripts.
Bash does not have the stop or newgrp builtins.
The SVR4.2 sh uses a TIMEOUT variable like Bash uses TMOUT.

More features unique to Bash may be found in Chapter 6 [Bash Features], page 91.

B.1 Implementation Differences From The SVR4.2 Shell

Since Bash is a completely new implementation, it does not suffer from many of the limi-
tations of the SVR4.2 shell. For instance:

Bash does not allow unbalanced quotes. The SVR4.2 shell will silently insert a needed
closing quote at EOF under certain circumstances. This can be the cause of some hard-
to-find errors.

In a questionable attempt at security, the SVR4.2 shell, when invoked without the -p
option, will alter its real and effective uid and gid if they are less than some magic
threshold value, commonly 100. This can lead to unexpected results.

The SVR4.2 shell does not allow the IFS, MAILCHECK, PATH, PS1, or PS2 variables to

be unset.

^| Bash allows multiple option arguments when it is invoked (-x -v); the SVR4.2 shell
allows only one option argument (-xv). In fact, some versions of the shell dump core
if the second argument begins with a .
