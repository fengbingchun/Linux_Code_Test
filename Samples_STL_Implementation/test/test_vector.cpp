#include <iostream>
#include "vector.hpp"
#include "string.hpp"

#define std fbcstd

int main()
{

{ // constructor, capacity, size, empty, data
	std::vector<int> vec1;
	fprintf(stdout, "vec1 size: %d, capacity: %d, empty: %d\n", vec1.size(), vec1.capacity(), vec1.empty());
	std::vector<int> vec2(1);
	fprintf(stdout, "vec2 size: %d, capacity: %d, empty: %d\n", vec2.size(), vec2.capacity(), vec2.empty());
	fprintf(stdout, "vec2 data: %d\n", *(vec2.data()));
	std::vector<std::string> vec3(5, "test vector");
	fprintf(stdout, "vec3 size: %d, capacity: %d, empty: %d\n", vec3.size(), vec3.capacity(), vec3.empty());
	const std::string* p1 = vec3.data();
	fprintf(stdout, "vec3 data: \n");
	for (size_t i = 0; i < vec3.size(); ++i) {
		fprintf(stdout, " %s,", (*p1).c_str());
		p1++;
	}
	std::vector<std::string> vec4(vec3);
	fprintf(stdout, "\nvec4 size: %d, capacity: %d, empty: %d\n", vec4.size(), vec4.capacity(), vec4.empty());
	std::string* p2 = vec4.data();
	fprintf(stdout, "vec4 data: \n");
	for (size_t i = 0; i < vec4.size(); ++i)
		*p2++ = "TEST VECTOR";
	const std::string* p3 = vec4.data();
	for (size_t i = 0; i < vec4.size(); ++i) {
		fprintf(stdout, " %s,", (*p3).c_str());
		p3++;
	}
	fprintf(stdout, "\n");
}

{ // at, [], =, clear
	std::vector<std::string> vec1(2);
	vec1.at(0) = "test";
	vec1.at(1) = "vector";
	fprintf(stdout, "vec1: %s, %s\n", vec1.at(0).c_str(), vec1.at(1).c_str());
	vec1[0] = "TEST";
	vec1[1] = "VECTOR";
	fprintf(stdout, "vec1: %s, %s\n", vec1[0].c_str(), vec1[1].c_str());
	
	std::vector<std::string> vec2;
	vec2 = vec1;
	fprintf(stdout, "vec2 size: %d, %s, %s\n", vec2.size(), vec2[0].c_str(), vec2[1].c_str());
	vec2.clear();
	fprintf(stdout, "vec2 size: %d\n", vec2.size());
}

{ // back, front
	std::vector<int> vec(2, 1000);
	fprintf(stdout, "value: %d\n", vec.back());
	vec.back() = -1000;
	fprintf(stdout, "value: %d\n", vec.back());
	fprintf(stdout, "value: %d\n", vec.front());
	vec.front() = -1000;
	fprintf(stdout, "value: %d\n", vec.front());
}

{ // push_back, pop_back
	std::vector<int> vec;
	for (int i = 0; i < 10; ++i)
		vec.push_back((i+1)*10);
	fprintf(stdout, "vec: size: %d, capacity: %d\nvalue: ", vec.size(), vec.capacity());
	for (int i = 0; i < vec.size(); ++i)
		fprintf(stdout, " %d,", vec[i]);

	for (int i = 0; i < 5; ++i)
		vec.pop_back();
	fprintf(stdout, "\nvec: size: %d, capacity: %d\nvalue: ", vec.size(), vec.capacity());
	for (int i = 0; i < vec.size(); ++i)
		fprintf(stdout, " %d,", vec[i]);
	fprintf(stdout, "\n");	
}

{ // resize
	std::vector<int> myvector;

  	for (int i = 1; i < 10; ++i)
		myvector.push_back(i);

	myvector.resize(5);
	myvector.resize(8,100);
	myvector.resize(12);

	fprintf(stdout, "myvector contains:");
	for (size_t i = 0; i < myvector.size(); ++i)
		fprintf(stdout, " %d,", myvector[i]);
	fprintf(stdout, "\n");
}

{ // begin, end
	std::vector<int> myvector;
	for (int i = 1; i <= 5; ++i)
		myvector.push_back(i);

	fprintf(stdout, "myvector contains:");
	for (std::vector<int>::iterator it = myvector.begin() ; it != myvector.end(); ++it)
		fprintf(stdout, " %d,", *it);
	fprintf(stdout, "\n");
	for (std::vector<int>::const_iterator it = myvector.begin() ; it != myvector.end(); ++it)
		fprintf(stdout, " %d,", *it);
	fprintf(stdout, "\n");
}

{ // compare operator
	std::vector<int> foo (3,100);
	std::vector<int> bar (2,200);

	if (foo == bar) fprintf(stdout, "foo and bar are equal\n");
	if (foo != bar) fprintf(stdout, "foo and bar are not equal\n");
	if (foo < bar) fprintf(stdout, "foo is less than bar\n");
	if (foo > bar) fprintf(stdout, "foo is greater than bar\n");
	if (foo <= bar)	fprintf(stdout, "foo is less than or equal to bar\n");
	if (foo >=bar)	fprintf(stdout, "foo is greater than or equal to bar\n");
}

	return 0;
}

