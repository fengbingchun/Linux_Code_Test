#include <iostream>
#include "string.hpp"

#define std fbcstd

int main()
{

{ // constructor
	std::string s0("Initial string");
	fprintf(stdout, "s0: %s\n", s0.c_str());
	std::string s1;
	fprintf(stdout, "s1: %s\n", s1.c_str());
	std::string s2(s0);
	fprintf(stdout, "s2: %s\n", s2.c_str());
	std::string s3(s0, 8, 3);
	fprintf(stdout, "s3: %s\n", s3.c_str());
	std::string s4("A character sequence ");
	fprintf(stdout, "s4: %s\n", s4.c_str());
	std::string s5("Another character sequence", 12);
	fprintf(stdout, "s5: %s\n", s5.c_str());
	std::string s6a(10, 'x');
	fprintf(stdout, "s6a: %s\n", s6a.c_str());
	std::string s6b(10, 42);
	fprintf(stdout, "s6b: %s\n", s6b.c_str());
} // constructor

{ // length, size, c_str()
	std::string str("Test string");
	fprintf(stdout, "str length: %d\n", str.length());
	fprintf(stdout, "str size: %d\n", str.size());
	fprintf(stdout, "str: %s\n", str.c_str());
}

{ // operator []
	std::string str("Test String");
	const char &c1 = str[0], &c2 = str[5];
	fprintf(stdout, "c1: %c; c2: %c; str: %s\n", c1, c2, str.c_str());
	char &c3 = str[0], &c4 = str[5];
	c3 = 't'; c4 = 's';
	fprintf(stdout, "c3: %c; c4: %c; str: %s\n", c3, c4, str.c_str());
}

{ // operator =
	std::string str("https://blog.csdn.net/fengbingchun/");
	std::string str1, str2, str3;
	str1 = str;
	str2 = "https://github.com/fengbingchun";
	str3 = 'x';
	fprintf(stdout, "str1: %s; str2: %s; str3: %s\n", str1.c_str(), str2.c_str(), str3.c_str());
}

{ // operator +=
	std::string name("John");
	std::string family("Smith");
	name += " K. ";
	name += family;
	name += '\n';
	fprintf(stdout, "name: %s", name.c_str());
}

{ // append
	std::string str1 = "CSDN: ";
	std::string str2 = "https://blog.csdn.net/fengbingchun/";
	str1.append(str2);
	fprintf(stdout, "str1: %s\n", str1.c_str());

	std::string str3("GitHub: ");
	str3.append("https://github.com/fengbingchun");
	fprintf(stdout, "str3: %s\n", str3.c_str());
}

{ // assign
	std::string str1, str2;
	std::string str3("CSDN: https://blog.csdn.net/fengbingchun/");
	str1.assign(str3);
	fprintf(stdout, "str1: %s\n", str1.c_str());	

 	str2.assign("GitHub: https://github.com/fengbingchun");
	fprintf(stdout, "str2: %s\n", str2.c_str());
}

{ // at
	std::string str("Test String");
	const char& a = str.at(5);
	fprintf(stdout, "a: %c, str: %s\n", a, str.c_str());

	char& b = str.at(5);
	b = 's';
	fprintf(stdout, "b: %c, str: %s\n", b, str.c_str());
	 
}

{ // clear
	std::string str("Test String");
	fprintf(stdout, "str: %s\n", str.c_str());
	str.clear();
	fprintf(stdout, "str: %s\n", str.c_str());
}

{ // compare
	std::string str1("Test"), str2("String"), str3("Apple"), str4("String");
	fprintf(stdout, "str2:str1: %d; st2:str3: %d; str2:str4: %d\n",
		str2.compare(str1), str2.compare(str3), str2.compare(str4));
	fprintf(stdout, "str2:str1: %d; st2:str3: %d; str2:str4: %d\n",
		str2.compare("Test"), str2.compare("Apple"), str2.compare("String"));
}

{ // data, empty
	std::string str("Test String"), str2;
	fprintf(stdout, "str: %s\n", str.data());

	fprintf(stdout, "str is empty: %d; st2 is empty: %d\n", str.empty(), str2.empty());
}

{ // operator +
	std::string firstlevel("com");
	std::string secondlevel("cplusplus");
	std::string scheme("http://");
	std::string hostname;
	std::string url;
	
	hostname = "www." + secondlevel + '.' + firstlevel;
	url = scheme + hostname;
	fprintf(stdout, "url: %s\n", url.c_str());
}

{ // operator: ==, !=, <, <=, >, >=
	std::string foo = "alpha";
	std::string bar = "beta";
	
	if (foo == bar) fprintf(stdout, "foo == bar\n");
	if (foo != bar) fprintf(stdout, "foo != bar\n");
	if (foo < bar) fprintf(stdout, "foo < bar\n");
	if (foo > bar) fprintf(stdout, "foo > bar\n");
	if (foo <= bar) fprintf(stdout, "foo <= bar\n");
	if (foo >= bar) fprintf(stdout, "foo >= bar\n");
}

	return 0;
}

