#ifndef FBC_LIBRARY_LIBRARY_HPP_
#define FBC_LIBRARY_LIBRARY_HPP_

// reference: https://gcc.gnu.org/wiki/Visibility
//            https://developer.apple.com/library/content/documentation/DeveloperTools/Conceptual/CppRuntimeEnv/Articles/SymbolVisibility.html

#ifdef __GNUC__ >= 4 // it means the compiler is GCC version 4.0 or later
	#ifdef defined FBC_EXPORT
		#define FBC_API_PUBLIC __attribute__((visibility ("default")))
		#define FBC_API_LOCAL __attribute__((visibility("hidden")))
	#else
		#define FBC_API_PUBLIC
		#deifne FBC_API_LOCAL
	#endif
#endif

#ifdef __cplusplus
extern "C" {
#endif

FBC_API_PUBLIC int library_add(int a, int b);
FBC_API_LOCAL void print_log();
FBC_API_PUBLIC int value;

#ifdef __cplusplus
}
#endif

template<typename T>
class FBC_API_PUBLIC Simple {
public:
	Simple() = default;
	void Init(T a, T b);
	T Add() const;

private:
	T a, b;
};


#endif // FBC_LIBRARY_LIBRARY_HPP_
