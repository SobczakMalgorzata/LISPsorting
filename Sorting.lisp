(defun subCompare (x y typePredicate areEqual isLessThan)
	"Sum any two numbers after printing a message."
	;(format t "Comparing ~d and ~d. ~%" x y)
	(if (apply typePredicate (list x))
		(if (apply typePredicate (list y))
			(cond 
				((apply areEqual (list x y)) 0)
				((apply isLessThan (list x y)) -1)
				(T 1)
			)
			-1
		)
		(if (apply typePredicate (list y)) 1 NIL)
	)
)

(defun listCompare (listA listB)
	(case (compare (car listA) (car listB))
		( 0 (compare (cdr listA) (cdr listB)) )	
		( 1 1)
		( -1 -1)
		(otherwise NIL)
	)
)

(defun compare (x y)
	"Universal comaparer. Returns -1 if x is smaller than y, 0 if they are equal and 1 if y is smaller."
	(cond
		((and (null x) (null y)) 0)
		((null x) -1)
		((null y) 1)
		((subCompare x y #'numberp #'eql #'<))
		((subCompare x y #'characterp #'CHAR= #'CHAR<))
		((subCompare x y #'stringp #'STRING= #'STRING<))
		((listCompare x y))
		(T (format t "Can't compare ~d and ~d.~%" x y))
	)
)

(defmacro seqcompare (compareF sequence)
	(let ((seq-name (gensym)) (len-name (gensym)))
		`(let* ( (,seq-name ,sequence) (,len-name (length ,seq-name)) )
			(progn
			(format T "Sequence= ~a ~% " ,seq-name)
			(if (< 1 ,len-name) 
				(progn
					(format T "Comparing A=[~a] B=[~a] ~% " (car ,seq-name) (cadr ,seq-name))
					(if (,compareF (compare (car ,seq-name) (cadr ,seq-name)) 0)
						(seqcompare ,compareF (cdr ,seq-name))
						NIL
					)
				)
				T
			)
			)
		)
	)
)

