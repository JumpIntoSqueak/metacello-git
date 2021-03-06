private
gitCommand: aString
	| proc cmdLine |
	cmdLine := self class gitPath, (' --git-dir="{1}{3}.git" --work-tree="{1}" {2}'
		format: {directory pathName. aString. FileDirectory slash}).
	proc := self osCommand: cmdLine.
	(proc exitStatus == 0) ifFalse: [
		| cmd |
		cmd := aString upTo: ($ ).
		FileStream stdout reopen nextPutAll: self class gitPath, ' ' , cmd , ' failed: ' , proc exitStatus; cr; flush.
		GitError from: cmd with: proc exitStatus.
	]