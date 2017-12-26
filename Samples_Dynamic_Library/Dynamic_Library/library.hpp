#ifndef FBC_LIBRARY_LIBRARY_HPP_
#define FBC_LIBRARY_LIBRARY_HPP_

// reference: https://gcc.gnu.org/wiki/Visibility
//            https://developer.apple.com/library/content/documentation/DeveloperTools/Conceptual/CppRuntimeEnv/Articles/SymbolVisibility.html

#ifdef __GNUC__ >= 4 // it means the compiler is GCC version 4.0 or later
	#ifdef FBC_EXPORT
		#warning "===== dynamic library ====="
		#define FBC_API_PUBLIC __attribute__((visibility ("default")))
		#define FBC_API_LOCAL __attribute__((visibility("hidden")))
	#else
		#warning "===== static library ====="
		#define FBC_API_PUBLIC
		#define FBC_API_LOCAL
	#endif
#else
	#error "##### requires gcc version >= 4.0 #####"
#endif
 
#ifdef __cplusplus
extern "C" {
#endif

FBC_API_PUBLIC int library_add(int a, int b);
FBC_API_LOCAL void print_log();

#ifdef FBC_EXPORT
FBC_API_PUBLIC int value;
#endif

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
