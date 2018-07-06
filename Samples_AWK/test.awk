#! /bin/bash/awk

BEGIN {
    # 在BEGIN中FILENAME不起作用
    print "// ===== start process file: " ARGV[1]
    # author为外部传进来的变量名
    print "// Author: " author
    print "// file "

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

}

END {
    print "// blog: "blog" "
    print "// github: "github" "
    print "// ===== end process file: " FILENAME
}