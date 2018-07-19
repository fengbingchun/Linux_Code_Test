#include <iostream>
#include <getopt.h>
#include <string.h>

// blog: https://blog.csdn.net/fengbingchun/article/details/81123563

int main(int argc, char* argv[])
{
	// reference: http://man7.org/linux/man-pages/man3/getopt.3.html
	int c;
	int digit_optind = 0;

	while (1) {
		int this_option_optind = optind ? optind : 1;
		int option_index = 0;
		static struct option long_options[] = {
			{"add",		required_argument,	0,	0},
			{"append",	no_argument,		0,	0},
			{"delete",	required_argument, 	0,	0},
			{"verbose",	no_argument,		0,	0},
			{"create",	required_argument,	0,	'c'},
			{"file",	required_argument,	0,	0},
			{0,		0,			0,	0}
		};

		c = getopt_long(argc, argv, "abc:d:012", long_options, &option_index);
		if (c == -1) break;

		switch (c) {
		case 0:
			//fprintf(stdout, "option %s ", long_options[option_index].name);
			//if (optarg) fprintf(stdout, "with arg %s", optarg);
			//fprintf(stdout, "\n");

			if (strcmp(long_options[option_index].name, "add") == 0)
				fprintf(stdout, "long option \"add\" value: %s\n", optarg);
			else if (strcmp(long_options[option_index].name, "append") == 0)
				fprintf(stdout, "long option \"append\"\n");
			else if (strcmp(long_options[option_index].name, "delete") == 0)
				fprintf(stdout, "long option \"delete\" value: %s\n", optarg);
			else if (strcmp(long_options[option_index].name, "create") == 0)
				fprintf(stdout, "long option \"create\" value: %s\n", optarg);
			else if (strcmp(long_options[option_index].name, "verbose") == 0)
				fprintf(stdout, "long option \"verbose\"\n");
			else if (strcmp(long_options[option_index].name, "file") == 0)
				fprintf(stdout, "long option \"file\" value: %s\n", optarg);
			break;
		case '0':
		case '1':
		case '2':
			if (digit_optind != 0 && digit_optind != this_option_optind)
				fprintf(stdout, "digits occur in two different argv elements.\n");
			digit_optind = this_option_optind;
			fprintf(stdout, "option %c\n", c);
			break;
		case 'a':
			fprintf(stdout, "option a\n");
			break;
		case 'b':
			fprintf(stdout, "option b\n");
			break;
		case 'c':
			fprintf(stdout, "option c with value '%s'\n", optarg);
			break;
		case 'd':
			fprintf(stdout, "option d with value '%s'\n", optarg);
			break;
		case '?':
			break;
		default:
			fprintf(stdout, "?? getopt returned character code 0%o ??\n", c);
		}	
	}

	if (optind < argc) {
		fprintf(stdout, "non-option argv elements: ");
		while (optind < argc)
			fprintf(stdout, "%s ", argv[optind++]);
		fprintf(stdout, "\n");
	}


	exit(EXIT_SUCCESS);
}

