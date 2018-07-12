#include <dirent.h>
#include <string.h>
#include <iostream>
#include <vector>
#include <string>

namespace {

void Usage(const char* exe)
{
	fprintf(stderr, "input params error, run this exe as following command line:\n");
	fprintf(stderr, "\t%s arg1 arg2 arg3\n", exe);
	fprintf(stderr, "\targ1: specify the directory to traverse\n");
    fprintf(stderr, "\targ2: type:\n"
        "\t\t0: tarverse all files and all directories in directory;\n"
        "\t\t1: only tarverse all files, don't include directories in directory;\n"
        "\t\t2: only tarverse all directories, don't include files in directory.\n");
    fprintf(stderr, "\targ3: optional, filter, default is *, which is don't filter. \n");
	fprintf(stderr, "for example(support relative path), only traverse jpg image:\n");
	fprintf(stderr, "\t%s ./images 0 .jpg\n", exe);
    fprintf(stderr, "##### test fail #####\n");
}

// 遍历指定文件夹下的所有文件，不包括指定文件夹内的文件夹
std::vector<std::string> GetListFiles(const std::string& path, const std::string& exten = "*")
{
    std::vector<std::string> list;
    list.clear();

    DIR* dp = nullptr;
    struct dirent* dirp = nullptr;
    if ((dp = opendir(path.c_str())) == nullptr) {
        return list;
    }

    while ((dirp = readdir(dp)) != nullptr) {
        if (dirp->d_type == DT_REG) {
            if (exten.compare("*") == 0)
                list.emplace_back(static_cast<std::string>(dirp->d_name));
            else
                if (std::string(dirp->d_name).find(exten) != std::string::npos)
                    list.emplace_back(static_cast<std::string>(dirp->d_name));
        }
    }

    closedir(dp);

    return list;
}

// 遍历指定文件夹下的所有文件夹，不包括指定文件夹下的文件
std::vector<std::string> GetListFolders(const std::string& path, const std::string& exten = "*")
{
    std::vector<std::string> list;
    list.clear();

    DIR* dp = nullptr;
    struct dirent* dirp = nullptr;
    if ((dp = opendir(path.c_str())) == nullptr) {
        return list;
    }

    while ((dirp = readdir(dp)) != nullptr) {
        if (dirp->d_type == DT_DIR && strcmp(dirp->d_name, ".") != 0 && strcmp(dirp->d_name, "..") != 0) {
            if (exten.compare("*") == 0)
                list.emplace_back(static_cast<std::string>(dirp->d_name));
            else
                if (std::string(dirp->d_name).find(exten) != std::string::npos)
                    list.emplace_back(static_cast<std::string>(dirp->d_name));
        }
    }

    closedir(dp);

    return list;
}

// 遍历指定文件夹下的所有文件，包括指定文件夹内的文件夹
std::vector<std::string> GetListFilesR(const std::string& path, const std::string& exten = "*")
{
    std::vector<std::string> list = GetListFiles(path, exten);

    std::vector<std::string> dirs = GetListFolders(path, exten);

    for (auto it = dirs.cbegin(); it != dirs.cend(); ++it) {
        std::vector<std::string> cl = GetListFiles(*it, exten);
        for (auto file : cl) {
            list.emplace_back(*it + "/" + file);
        }
    }

    return list;
}

} // namespace

int main(int argc, char* argv[])
{
    if (argc < 3 || argc > 4) {
        Usage(argv[0]);
        return -1;
    }

    int type = atoi(argv[2]);
    std::string exten = "*";
    if (argc == 4) exten = std::string(argv[3]);

    std::vector<std::string> vec;
    if (type == 0) vec = GetListFilesR(std::string(argv[1]), exten);
    else if (type == 1) vec = GetListFiles(std::string(argv[1]), exten);
    else if (type == 2) vec = GetListFolders(std::string(argv[1]), exten);
    else { Usage(argv[0]); return -1;}

    fprintf(stdout, "traverse result: files count: %d\n", vec.size());
    for (auto& file : vec) {
        fprintf(stderr, "\t%s\n", file.c_str());
    }

    fprintf(stdout, "===== test success =====\n");
}