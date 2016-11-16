#include <iostream>
#include <vector>
#include <fstream>
#include <iomanip>

using namespace std;

vector<string> split(string line)
{
	vector<string> words;
	int rear = 0, front = 0;

	while (1) {
		char ch;
		bool flag = false;
		if (front == line.length()) {
			ch = ' ';
			flag = true;
		} else
			ch = line.at(front);
		string word;
		int length;
		bool isSplit = false;
		bool isSymbol = false;
		switch (ch) {
		case ':':
			length = front - rear + 1;
			isSplit = true;
			break;
		case '\n':
		case '\r':
		case ' ':
		case '\t':
		case ',':
			length = front - rear;
			isSplit = true;
			break;
		case '(':
		case ')':
		case '[':
		case ']':
		case '+':
			length = front - rear;
			isSplit = true;
			isSymbol = true;
			break;
		}
		if (isSplit) {
			word = line.substr(rear, length);
			if (word.length())
				words.push_back(word);
			if (isSymbol)
				words.push_back(line.substr(front, 1));
			rear = front + 1;

		}
		if (flag)
			break;
		front++;
	}

	return words;
}

vector<string> read(char* fpath)
{
	vector<string> words;

	ifstream ifs(fpath);
	if (ifs.fail()) {
		cerr << "Cannot open an asm file" << endl;
		return words;
	}

	string line;
	while (getline(ifs, line)) {
		vector<string> newWords = split(line);
		words.insert(words.end(), newWords.begin(), newWords.end());
	}

	return words;
}

int hlt_(unsigned char c, vector<unsigned char>& code)
{
	code.push_back(c);
	return 1;
}

int hlt(const vector<string> words, int idx, vector<unsigned char>& code)
{
	return hlt_(0x08, code);
}

int nop(const vector<string> words, int idx, vector<unsigned char>& code)
{
	return hlt_(0x00, code);
}

int in(const vector<string> words, int idx, vector<unsigned char>& code)
{
	return hlt_(0x18, code);
}

int out(const vector<string> words, int idx, vector<unsigned char>& code)
{
	return hlt_(0x10, code);
}

int rcf(const vector<string> words, int idx, vector<unsigned char>& code)
{
	return hlt_(0x20, code);
}

int scf(const vector<string> words, int idx, vector<unsigned char>& code)
{
	return hlt_(0x28, code);
}

int regea(unsigned char c, const vector<string> words, int idx, vector<unsigned char>& code)
{
	string reg = words[idx + 1];
	if (reg == "ACC")
		c &= 0xf7;
	else if (reg == "IX")
		c |= 0x08;
	else {
		cerr << "Invalid reg : " << reg << endl;
		return 1;
	}
	bool withValue = false;
	int length = 3;
	string value;
	if (words[idx + 2] == "ACC")
		c &= 0xf8;
	else if (words[idx + 2] == "IX")
		c |= 0x01;
	else if (words[idx + 2] == "(") {
		withValue = true;
		if (words[idx + 3] == "IX") {
			c |= 0x07;
			length = 7;
		} else {
			c |= 0x06;
			length = 5;
		}
		value = words[idx + length - 2];
	} else if (words[idx + 2] == "[") {
		withValue = true;
		if (words[idx + 3] == "IX") {
			c |= 0x05;
			length = 7;
		} else {
			c |= 0x04;
			length = 5;
		}
		value = words[idx + length - 2];
	} else {
		withValue = true;
		c |= 0x02;
		length = 3;
		value = words[idx + length - 1];
	}
	code.push_back(c);
	if (withValue) {
		value.pop_back();
		code.push_back((unsigned char)stol(value, nullptr, 16));
	}
	return length;
}

int ld(const vector<string> words, int idx, vector<unsigned char>& code)
{
	return regea(0x60, words, idx, code);
}

int regma(unsigned char c, const vector<string> words, int idx, vector<unsigned char>& code)
{
	string reg = words[idx + 1];
	if (reg == "ACC")
		c &= 0xf7;
	else if (reg == "IX")
		c |= 0x08;
	else {
		cerr << "Invalid reg : " << reg << endl;
		return 1;
	}
	int length = 3;
	string value;
	if (words[idx + 2] == "(") {
		if (words[idx + 3] == "IX") {
			c |= 0x07;
			length = 7;
		} else {
			c |= 0x06;
			length = 5;
		}
		value = words[idx + length - 2];
	} else if (words[idx + 2] == "[") {
		if (words[idx + 3] == "IX") {
			c |= 0x05;
			length = 7;
		} else {
			c |= 0x04;
			length = 5;
		}
		value = words[idx + length - 2];
	} else {
		cerr << "Invalid ma : " << words[idx + 2] << endl;
		return 1;
	}
	code.push_back(c);
	value.pop_back();
	code.push_back((unsigned char)stol(value, nullptr, 16));
	return length;
}

int st(const vector<string> words, int idx, vector<unsigned char>& code)
{
	return regma(0x70, words, idx, code);
}

int add(const vector<string> words, int idx, vector<unsigned char>& code)
{
	return regea(0xb0, words, idx, code);
}

int adc(const vector<string> words, int idx, vector<unsigned char>& code)
{
	return regea(0x90, words, idx, code);
}

int sub(const vector<string> words, int idx, vector<unsigned char>& code)
{
	return regea(0xa0, words, idx, code);
}

int sbc(const vector<string> words, int idx, vector<unsigned char>& code)
{
	return regea(0x80, words, idx, code);
}

int cmp(const vector<string> words, int idx, vector<unsigned char>& code)
{
	return regea(0xf0, words, idx, code);
}

int and_(const vector<string> words, int idx, vector<unsigned char>& code)
{
	return regea(0xe0, words, idx, code);
}

int or_(const vector<string> words, int idx, vector<unsigned char>& code)
{
	return regea(0xd0, words, idx, code);
}

int eor(const vector<string> words, int idx, vector<unsigned char>& code)
{
	return regea(0xc0, words, idx, code);
}

int ssm_(unsigned char c_, unsigned char c, const vector<string> words, int idx, vector<unsigned char>& code)
{
	c |= c_;
	if (words[idx + 1] == "ACC")
		c &= 0xf7;
	else if (words[idx + 1] == "IX")
		c |= 0x08;
	else {
		cerr << "Invalid reg : " << words[idx + 1] << endl;
		return 1;
	}
	code.push_back(c);
	return 2;
}

int ssm(unsigned char c, const vector<string> words, int idx, vector<unsigned char>& code)
{
	return ssm_(0x40, c, words, idx, code);
}

int rsm(unsigned char c, const vector<string> words, int idx, vector<unsigned char>& code)
{
	return ssm_(0x44, c, words, idx, code);
}

int bcc(unsigned char c, const vector<string> words, int idx, vector<unsigned char>& code)
{
	c |= 0x30;
	code.push_back(c);
	string value = words[idx + 1];
	value.pop_back();
	code.push_back((unsigned char)stol(value, nullptr, 16));
	return 2;
}

vector<unsigned char> assemble(const vector<string> words, vector<int>& indexes)
{
	int idx = 0;
	vector<unsigned char> code;
	while (idx < words.size()) {
		indexes.push_back(code.size());
		if (words[idx] == "HLT")
			idx += hlt(words, idx, code);
		else if (words[idx] == "NOP")
			idx += nop(words, idx, code);
		else if (words[idx] == "IN")
			idx += in(words, idx, code);
		else if (words[idx] == "OUT")
			idx += out(words, idx, code);
		else if (words[idx] == "RCF")
			idx += rcf(words, idx, code);
		else if (words[idx] == "SCF")
			idx += scf(words, idx, code);
		else if (words[idx] == "LD")
			idx += ld(words, idx, code);
		else if (words[idx] == "ST")
			idx += st(words, idx, code);
		else if (words[idx] == "ADD")
			idx += add(words, idx, code);
		else if (words[idx] == "ADC")
			idx += adc(words, idx, code);
		else if (words[idx] == "SUB")
			idx += sub(words, idx, code);
		else if (words[idx] == "SBC")
			idx += sbc(words, idx, code);
		else if (words[idx] == "CMP")
			idx += cmp(words, idx, code);
		else if (words[idx] == "AND")
			idx += and_(words, idx, code);
		else if (words[idx] == "OR")
			idx += or_(words, idx, code);
		else if (words[idx] == "EOR")
			idx += eor(words, idx, code);
		else if (words[idx] == "SRA")
			idx += rsm(0x00, words, idx, code);
		else if (words[idx] == "SLA")
			idx += rsm(0x01, words, idx, code);
		else if (words[idx] == "SRL")
			idx += rsm(0x02, words, idx, code);
		else if (words[idx] == "SLL")
			idx += rsm(0x03, words, idx, code);
		else if (words[idx] == "RRA")
			idx += rsm(0x00, words, idx, code);
		else if (words[idx] == "RLA")
			idx += rsm(0x01, words, idx, code);
		else if (words[idx] == "RRL")
			idx += rsm(0x02, words, idx, code);
		else if (words[idx] == "RLL")
			idx += rsm(0x03, words, idx, code);
		else if (words[idx] == "BA")
			idx += bcc(0x00, words, idx, code);
		else if (words[idx] == "BVF")
			idx += bcc(0x08, words, idx, code);
		else if (words[idx] == "BNZ")
			idx += bcc(0x01, words, idx, code);
		else if (words[idx] == "BZ")
			idx += bcc(0x09, words, idx, code);
		else if (words[idx] == "BZP")
			idx += bcc(0x02, words, idx, code);
		else if (words[idx] == "BN")
			idx += bcc(0x0a, words, idx, code);
		else if (words[idx] == "BP")
			idx += bcc(0x03, words, idx, code);
		else if (words[idx] == "BZN")
			idx += bcc(0x0b, words, idx, code);
		else if (words[idx] == "BNI")
			idx += bcc(0x04, words, idx, code);
		else if (words[idx] == "BNO")
			idx += bcc(0x0c, words, idx, code);
		else if (words[idx] == "BNC")
			idx += bcc(0x05, words, idx, code);
		else if (words[idx] == "BC")
			idx += bcc(0x0d, words, idx, code);
		else if (words[idx] == "BGE")
			idx += bcc(0x06, words, idx, code);
		else if (words[idx] == "BLT")
			idx += bcc(0x0e, words, idx, code);
		else if (words[idx] == "BGT")
			idx += bcc(0x07, words, idx, code);
		else if (words[idx] == "BLE")
			idx += bcc(0x0f, words, idx, code);
		else {
			cerr << "Invalid code : " << words[idx] << endl;
			break;
		}
	}
	indexes.push_back(code.size());
	return code;
}

int main(int argc, char** argv)
{
	if (argc != 2) {
		cerr << "Invalid arguments" << endl;
		return 1;
	}

	vector<string> words = read(argv[1]);

	vector<int> indexes;
	vector<unsigned char> code = assemble(words, indexes);

	for (int i = 0; i < indexes.size() - 1; i++) {
		for (int j = indexes[i]; j < indexes[i + 1]; j++)
			cout << hex << setw(2) << setfill('0') << (int)code[j] << " ";
		cout << endl;
	}

	/*
	for (int i = 0; i < words.size(); i++)
		cout << words[i] << endl;
		*/

	return 0;
}

