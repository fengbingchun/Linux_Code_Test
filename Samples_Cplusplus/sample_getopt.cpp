#include <iostream>
#include <unistd.h>

// blog: https://blog.csdn.net/fengbingchun/article/details/81122843

namespace {

void test1(int argc, char* argv[])
{
	// reference: http://man7.org/linux/man-pages/man3/getopt.3.html
	int flags = 0, opt = -1, nsecs = 0, tfnd = 0;
	while ((opt = getopt(argc, argv, "nt:")) != -1) {
		switch (opt) {
		case 'n':
			flags =1;
			break;
		case 't':
			nsecs = atoi(optarg);
			tfnd = 1;
			break;
		default:
			fprintf(stderr, "Usage: %s [-t nsecs] [-n] name\n", argv[0]);
			exit(EXIT_FAILURE);
		}
	}
	
	fprintf(stdout, "flags = %d; tfnd = %d; nsec = %d; optind = %d\n", flags, tfnd, nsecs, optind);

	if (optind >= argc) {
		fprintf(stderr, "Expected argument after options\n");
		exit(EXIT_FAILURE);
	}

	fprintf(stdout, "name argument = %s\n", argv[optind]);

	exit(EXIT_SUCCESS);
}

int test2()
{
	// reference: https://stackoverflow.com/questions/10502516/how-to-call-correctly-getopt-function
	const char* argv[] = {"ProgramNameHere", "-f", "input.gmn", "-output.jpg"};
	int argc = sizeof(argv) / sizeof(argv[0]);
	std::cout<<"argc: "<<argc<<std::endl;
	for (int i = 0; i < argc; ++i) {
		//std::cout<<"argv: "<<argv[i]<<std::endl;
	}

	int c = -1;
	while ((c = getopt(argc, (char**)argv, "f:s:o:pw:h:z:t:d:a:b:?")) != -1) {
		std::cout<<"Option: "<<(char)c;
		if (optarg) {
			std::cout<<", argument: "<<optarg;
		}
		std::cout<<"\n";
	}

	return 0;
}

int test3(int argc, char* argv[])
{
	// reference: https://www.gnu.org/software/libc/manual/html_node/Example-of-Getopt.html
	// Normally, getopt is called in a loop. When getopt returns -1, indicating no more options are present, the loop terminates.
	// A switch statement is used to dispatch on the return value from getopt. In typical use, each case just sets a variable that is used later in the program.
	// A second loop is used to process the remaining non-option arguments.
	int aflag = 0, bflag = 0, index = -1, c = -1;
	char* cvalue = nullptr;
	opterr = 0;
	
	while ((c = getopt(argc, argv, "abc:")) != -1) {
		switch (c) {
		case 'a':
			aflag = 1;
			break;
		case 'b':
			bflag = 1;
			break;
		case 'c':
			cvalue = optarg;
			break;
		case '?':
			if (optopt == 'c')
				fprintf(stderr, "Option -%c requires an argument.\n", optopt);
			else if (isprint(optopt))
				fprintf(stderr, "Unknown option '-%c'.\n", optopt);
			else
				fprintf(stderr, "Unknown option character '\\x%x'.\n", optopt);
			return 1;
		default:
			abort();
		}
	}		

	fprintf(stdout, "aflag = %d, bflag = %d, cvalue = %s\n", aflag, bflag, cvalue);

	for (index = optind; index < argc; ++index) {
		fprintf(stdout, "index: %d, Non-option argument: %s\n", index, argv[index]);
	}
	
	return 0;
}

} // namespace

int main(int argc, char* argv[])
{
	if (argc < 2) {
		fprintf(stderr, "the number of params must be greater than or equal to 2\n");
		return -1;
	}

	int flag = atoi(argv[1]);
	switch(flag) {
	case 1:
		fprintf(stdout, "start test 1:\n");
		test1(argc, argv);
		break;
	case 2:
		fprintf(stdout, "start test 2:\n");
		test2();
		break;
	case 3:
		fprintf(stdout, "start test 3:\n");
		test3(argc, argv);
		break;
	default:
		fprintf(stderr, "params error\n");
		break;
	}

	return 0;
}

