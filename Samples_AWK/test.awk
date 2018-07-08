#! /bin/bash/awk

BEGIN {
    # 在BEGIN中FILENAME不起作用
    print "// ===== start process file: " ARGV[1]
    # author为外部传进来的变量名
    print "// Author: " author

    state = 0
    offset = 0
}

{
    if (match($0, "blog_name .* \"(.*)\"", s)) {
        blog = s[1]
    }

    if (match($0, "github_name .* \"(.*)\"", s)) {
        github = s[1]
    }

    if (FNR == 1) {
        print "// file name: " file1 > file1
        print "// Author: " author >> file1
        print "// ===== start process file: " FILENAME >> file1
        print "" >> file1
        print "// file name: " file2 > file2
        print "// Author: " author >> file2
        print "// ===== start process file: " FILENAME >> file2
        print "" >> file2
        print "unsigned char data[] = { " >> file2
    }

    if (state == 0 && $0 ~ "^    const unsigned char") {
        state = 1
        pos0 = index($0, "_")
        pos1 = index($0, "[")
        pos2 = index($0, "]")
        name = substr($0, pos0, pos1 - pos0)
        offsetstr = substr($0, pos1 + 1, pos2 - pos1 - 1)
        offsetl = 0 + offsetstr

        if (offsetl % 64 != 0) {
            remain = 64 - offsetl % 64
        } else {
            remain = 0
        }

        print "    const unsigned char* "name" = NULL;" >> file1
        print "    const unsigned int "name"_offset = " offset ";" >> file1
        offset += (offsetl + remain);
        print "// start data: " name >> file2

    } else if (state == 1) {
        if ($0 ~ "^    };") {
            print "// end data: " name >> file2;
            print "," >> file2
            print "// "name" remain: " remain >> file2;
            for (i = 0; i < remain; ++i) {
                printf("0x00, ") >> file2;
            }
            print "" >> file2
            state = 0;
        } else {
            print $0 >> file2
        }
    } else {
        print $0 >> file1
    }
}

END {
    printf "};\n\n" >> file2
    print "// blog: "blog" " >> file1
    print "// github: "github" " >> file2
    print "// ===== end process file: " FILENAME
    print "// ===== end process file: " FILENAME >> file1
    print "// ===== end process file: " FILENAME >> file2
}