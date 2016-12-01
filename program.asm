dptr1:	EQU 00h
dptr2:	EQU 0FAh
image:	EQU 0FBh
dptr:	EQU 0FCh
n2:	EQU 0FDh
n3:	EQU 0FEh
* 空白の繰り返し回数
n2s:	EQU 0FFh
n3s:	EQU 0FFh
n2max:	EQU 0FFh

	LD	ACC,dptr1
	ST	ACC,(dptr)

L0:	LD	ACC,(dptr)
	LD	IX,ACC
	ADD	ACC,03h
	ST	ACC,(dptr)

	SUB	ACC,dptr2
	BNZ	L1
	LD	ACC,dptr1
	ST	ACC,(dptr)

	LD	ACC,(IX+0)
	SUB	ACC,00h
	BZ	rest

L1:	LD	ACC,(IX+2)
	ST	ACC,(n3)
Ln3:	LD	ACC,(IX+1)
	ST	ACC,(n2)
Ln2:	LD	ACC,(image)
	OUT
	EOR	ACC,0FFh
	ST	ACC,(image)

	LD	ACC,(IX+0)
Ln1:	SUB	ACC,01h
	BNZ	Ln1

	LD	ACC,(n2)
	SUB	ACC,01h
	ST	ACC,(n2)
	BNZ	Ln2

	LD	ACC,(n3)
	SUB	ACC,01h
	ST	ACC,(n3)
	BNZ	Ln3

	LD	ACC,n3s
	ST	ACC,(n3)
	LD	ACC,n2s
	ST	ACC,(n2max)

space:	LD	ACC,00h
	OUT
Ln3s:	LD	ACC,(n2max)
	ST	ACC,(n2)

Ln2s:	LD	ACC,(n2)
	SUB	ACC,01h
	ST	ACC,(n2)
	BNZ	Ln2s

	LD	ACC,(n3)
	SUB	ACC,01h
	ST	ACC,(n3)
	BNZ	Ln3s

	BA	L0

rest:	LD	ACC,(IX+2)
	ST	ACC,(n3)
	LD	ACC,(IX+1)
	ST	ACC,(n2max)
	BA	space

	END

