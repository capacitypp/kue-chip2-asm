DIGIT: EQU 80h
	HLT
	NOP
	IN
	OUT
	SCF
	RCF
	LD	ACC,ACC
	LD	ACC,IX
	LD	ACC,DIGIT
	LD	ACC,(DIGIT)
	LD	ACC,[DIGIT]
	LD	ACC,(IX+DIGIT)
	LD	ACC,[IX+DIGIT]
	LD	IX,ACC
	LD	IX,IX
	LD	IX,DIGIT
	LD	IX,(DIGIT)
	LD	IX,[DIGIT]
	LD	IX,(IX+DIGIT)
	LD	IX,[IX+DIGIT]
	ST	ACC,(DIGIT)
	ST	ACC,[DIGIT]
	ST	ACC,(IX+DIGIT)
	ST	ACC,[IX+DIGIT]
	ST	IX,(DIGIT)
	ST	IX,[DIGIT]
	ST	IX,(IX+DIGIT)
	ST	IX,[IX+DIGIT]
	ADD	ACC,ACC
	ADD	ACC,IX
	ADD	ACC,DIGIT
	ADD	ACC,(DIGIT)
	ADD	ACC,[DIGIT]
	ADD	ACC,(IX+DIGIT)
	ADD	ACC,[IX+DIGIT]
	ADD	IX,ACC
	ADD	IX,IX
	ADD	IX,DIGIT
	ADD	IX,(DIGIT)
	ADD	IX,[DIGIT]
	ADD	IX,(IX+DIGIT)
	ADD	IX,[IX+DIGIT]
	ADC	ACC,ACC
	ADC	ACC,IX
	ADC	ACC,DIGIT
	ADC	ACC,(DIGIT)
	ADC	ACC,[DIGIT]
	ADC	ACC,(IX+DIGIT)
	ADC	ACC,[IX+DIGIT]
	ADC	IX,ACC
	ADC	IX,IX
	ADC	IX,DIGIT
	ADC	IX,(DIGIT)
	ADC	IX,[DIGIT]
	ADC	IX,(IX+DIGIT)
	ADC	IX,[IX+DIGIT]
	SUB	ACC,ACC
	SUB	ACC,IX
	SUB	ACC,DIGIT
	SUB	ACC,(DIGIT)
	SUB	ACC,[DIGIT]
	SUB	ACC,(IX+DIGIT)
	SUB	ACC,[IX+DIGIT]
	SUB	IX,ACC
	SUB	IX,IX
	SUB	IX,DIGIT
	SUB	IX,(DIGIT)
	SUB	IX,[DIGIT]
	SUB	IX,(IX+DIGIT)
	SUB	IX,[IX+DIGIT]
	SBC	ACC,ACC
	SBC	ACC,IX
	SBC	ACC,DIGIT
	SBC	ACC,(DIGIT)
	SBC	ACC,[DIGIT]
	SBC	ACC,(IX+DIGIT)
	SBC	ACC,[IX+DIGIT]
	SBC	IX,ACC
	SBC	IX,IX
	SBC	IX,DIGIT
	SBC	IX,(DIGIT)
	SBC	IX,[DIGIT]
	SBC	IX,(IX+DIGIT)
	SBC	IX,[IX+DIGIT]
	SBC	ACC,ACC
	SBC	ACC,IX
	SBC	ACC,DIGIT
	SBC	ACC,(DIGIT)
	SBC	ACC,[DIGIT]
	SBC	ACC,(IX+DIGIT)
	SBC	ACC,[IX+DIGIT]
	SBC	IX,ACC
	SBC	IX,IX
	SBC	IX,DIGIT
	SBC	IX,(DIGIT)
	SBC	IX,[DIGIT]
	SBC	IX,(IX+DIGIT)
	SBC	IX,[IX+DIGIT]
	CMP	ACC,ACC
	CMP	ACC,IX
	CMP	ACC,DIGIT
	CMP	ACC,(DIGIT)
	CMP	ACC,[DIGIT]
	CMP	ACC,(IX+DIGIT)
	CMP	ACC,[IX+DIGIT]
	CMP	IX,ACC
	CMP	IX,IX
	CMP	IX,DIGIT
	CMP	IX,(DIGIT)
	CMP	IX,[DIGIT]
	CMP	IX,(IX+DIGIT)
	CMP	IX,[IX+DIGIT]
	AND	ACC,ACC
	AND	ACC,IX
	AND	ACC,DIGIT
	AND	ACC,(DIGIT)
	AND	ACC,[DIGIT]
	AND	ACC,(IX+DIGIT)
	AND	ACC,[IX+DIGIT]
	AND	IX,ACC
	AND	IX,IX
	AND	IX,DIGIT
	AND	IX,(DIGIT)
	AND	IX,[DIGIT]
	AND	IX,(IX+DIGIT)
	AND	IX,[IX+DIGIT]
	OR	ACC,ACC
	OR	ACC,IX
	OR	ACC,DIGIT
	OR	ACC,(DIGIT)
	OR	ACC,[DIGIT]
	OR	ACC,(IX+DIGIT)
	OR	ACC,[IX+DIGIT]
	OR	IX,ACC
	OR	IX,IX
	OR	IX,DIGIT
	OR	IX,(DIGIT)
	OR	IX,[DIGIT]
	OR	IX,(IX+DIGIT)
	OR	IX,[IX+DIGIT]
	EOR	ACC,ACC
	EOR	ACC,IX
	EOR	ACC,DIGIT
	EOR	ACC,(DIGIT)
	EOR	ACC,[DIGIT]
	EOR	ACC,(IX+DIGIT)
	EOR	ACC,[IX+DIGIT]
	EOR	IX,ACC
	EOR	IX,IX
	EOR	IX,DIGIT
	EOR	IX,(DIGIT)
	EOR	IX,[DIGIT]
	EOR	IX,(IX+DIGIT)
	EOR	IX,[IX+DIGIT]
	SRA	ACC
	SRA IX
	SLA	ACC
	SLA IX
	SRL	ACC
	SRL IX
	SLL	ACC
	SLL IX
	RRA	ACC
	RRA IX
	RLA	ACC
	RLA IX
	RRL	ACC
	RRL IX
	RLL	ACC
	RLL IX
	BA	DIGIT
	BVF	DIGIT
	BNZ	DIGIT
	BZ	DIGIT
	BZP	DIGIT
	BN	DIGIT
	BP	DIGIT
	BZN	DIGIT
	BNI	DIGIT
	BNO	DIGIT
	BNC	DIGIT
	BC	DIGIT
	BGE	DIGIT
	BLT	DIGIT
	BGT	DIGIT
	BLE	DIGIT
	END


