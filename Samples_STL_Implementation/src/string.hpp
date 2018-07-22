#ifndef FBC_STL_STRING_HPP_
#define FBC_STL_STRING_HPP_

// blog: https://blog.csdn.net/fengbingchun/article/details/81154585

#include <string.h>

namespace fbcstd {

class string {
public:
	string();
	string(const string& str);
	string(const string& str, size_t pos, size_t len = npos);
	string(const char* s);
	string(const char* s, size_t n);
	string(size_t n, char c);
	~string();

	const char* c_str() const; 
	size_t length() const;
	size_t size() const;
	
	char& operator [] (size_t pos);
	const char& operator [] (size_t pos) const;
	string& operator = (const string& str);
	string& operator = (const char* s);
	string& operator = (char c);
	string& operator += (const string& str);
	string& operator += (const char* s);
	string& operator += (char c);

	string& append(const string& str);
	string& append(const char* s);

	string& assign(const string& str);
	string& assign(const char* s);

	char& at(size_t pos);
	const char& at(size_t pos) const;

	void clear();

	int compare(const string& str) const;
	int compare(const char* s) const;

	const char* data() const;
	bool empty() const;

	static const size_t npos = -1;

private:
	size_t size_;
	char* buffer_;
}; // class string

inline string::string()
{
	size_ = 0;
	buffer_ = new char[1];
	buffer_[0] = '\0';
}

inline string::string(const string& str)
{
	size_ = str.size_;
	buffer_ = new char[size_+1];
	strcpy(buffer_, str.buffer_);	
}

inline string::string(const string& str, size_t pos, size_t len)
{
	if (pos > str.size_) {
		size_ = 0;
		buffer_ = new char[1];
		buffer_[0] = '\0';
	} else {
		if (pos + len > str.size_)
			size_ = str.size_ - pos;
		else
			size_ = len;

		buffer_ = new char[size_+1];
		const char* p = str.c_str() + pos;
		
		for (size_t i = 0; i < size_; ++i) {
			buffer_[i] = p[i];
		}
		buffer_[size_] = '\0';
	}
}

inline string::string(const char* s)
{
	size_ = strlen(s);
	buffer_ = new char[size_+1];
	strcpy(buffer_, s);
}

inline string::string(const char* s, size_t n)
{
	if (strlen(s) <= n) {
		size_ = strlen(s);
		buffer_ = new char[size_+1];
		strcpy(buffer_, s);
	} else {
		size_ = n;
		buffer_ = new char[size_+1];
		strncpy(buffer_, s, n);
	}
}

inline string::string(size_t n, char c)
{
	size_ = n;
	buffer_ = new char[size_+1];
	memset(buffer_, c, n);
}

inline string::~string()
{
	if (buffer_)
		delete [] buffer_;
	size_ = 0;
}

inline const char* string::c_str() const
{
	return buffer_;
}

inline size_t string::length() const
{
	return size_;
}

inline size_t string::size() const
{
	return size_;
}
	
inline char& string::operator [] (size_t pos)
{
	return buffer_[pos];	
}
	
inline const char& string::operator [] (size_t pos) const
{
	if (pos >= size_)
		return '\0';
	else
		return buffer_[pos];	
}


inline string& string::operator = (const string& str)
{
	if (this->size_ != 0)
		delete [] buffer_;

	size_ = str.size_;
	buffer_ = new char[size_+1];
	strcpy(buffer_, str.c_str());
	return *this;
}

inline string& string::operator = (const char* s)
{
	if (this->size_ != 0)
		delete [] buffer_;

	size_ = strlen(s);
	buffer_ = new char[size_+1];
	strcpy(buffer_, s);
	return *this;
}

inline string& string::operator = (char c)
{
	if (this->size_ != 1)
		delete [] buffer_;

	size_ = 1;
	buffer_ = new char[size_+1];
	buffer_[0] = c;
	buffer_[size_] = '\0';
	return *this;
}
	
inline string& string::operator += (const string& str)
{
	size_ += str.size_;
	char* data = new char[size_+1];
	strcpy(data, buffer_);
	strcat(data, str.buffer_);

	delete [] buffer_;
	buffer_ = data;
	return *this;
}

inline string& string::operator += (const char* s)
{
	size_ += strlen(s);
	char* data = new char[size_+1];
	strcpy(data, buffer_);
	strcat(data, s);

	delete [] buffer_;
	buffer_ = data;
	return *this;
}

inline string& string::operator += (char c)
{
	size_ += 1;
	char* data = new char[size_+1];
	strcpy(data, buffer_);
	strcat(data, &c);

	delete [] buffer_;
	buffer_ = data;
	return *this;
}

inline string& string::append(const string& str)
{
	*this += str;
	return *this;
}

inline string& string::append(const char* s)
{
	*this += s;
	return *this;
}

inline string& string::assign(const string& str)
{
	*this = str;
	return *this;
}
	
inline string& string::assign(const char* s)
{
	*this = s;
	return *this;
}

inline char& string::at(size_t pos)
{
	return buffer_[pos];
}
	
inline const char& string::at(size_t pos) const
{
	return buffer_[pos];
}

inline void string::clear()
{
	delete [] buffer_;
	size_ = 0;
	buffer_ = new char[1];
	buffer_[0] = '\0';
}
	
inline int string::compare(const string& str) const
{
	return strcmp(buffer_, str.buffer_);
}

inline int string::compare(const char* s) const
{
	return strcmp(buffer_, s);
}

inline const char* string::data() const
{
	return buffer_;
}
	
inline bool string::empty() const
{
	return (size_ == 0);
}

static inline string operator + (const string& lhs, const string& rhs)
{
	string str(lhs);
	str += rhs;
	return str;
}

static inline string operator + (const string& lhs, const char* rhs)
{
	string str(lhs);
	str += rhs;
	return str;
}

static inline string operator + (const char* lhs, const string& rhs)
{
	string str(lhs);
	str += rhs;
	return str;
}

static inline string operator + (const string& lhs, char rhs)
{
	string str(lhs);
	str += rhs;
	return str;
}

static inline string operator + (char lhs, const string& rhs)
{
	string str(&lhs);
	str += rhs;
	return str;
}

static inline bool operator == (const string& lhs, const string& rhs)
{
	return (lhs.compare(rhs) == 0);
}

static inline bool operator == (const char* lhs, const string& rhs)
{
	return (rhs.compare(lhs) == 0);
}

static inline bool operator == (const string& lhs, const char* rhs)
{
	return (lhs.compare(rhs) == 0);
}

static inline bool operator != (const string& lhs, const string& rhs)
{
	return (lhs.compare(rhs) != 0);
}

static inline bool operator != (const char* lhs, const string& rhs)
{
	return (rhs.compare(lhs) != 0);
}

static inline bool operator != (const string& lhs, const char* rhs)
{
	return (lhs.compare(rhs) != 0);
}

static inline bool operator < (const string& lhs, const string& rhs)
{
	return (lhs.compare(rhs) < 0);
}

static inline bool operator < (const char* lhs, const string& rhs)
{
	return (rhs.compare(lhs) >= 0);
}

static inline bool operator < (const string& lhs, const char* rhs)
{
	return (lhs.compare(rhs) < 0);
}

static inline bool operator <= (const string& lhs, const string& rhs)
{
	return (lhs.compare(rhs) <= 0);
}

static inline bool operator <= (const char* lhs, const string& rhs)
{
	return (rhs.compare(lhs) > 0);
}

static inline bool operator <= (const string& lhs, const char* rhs)
{
	return (lhs.compare(rhs) <= 0);
}

static inline bool operator > (const string& lhs, const string& rhs)
{
	return (lhs.compare(rhs) > 0);
}

static inline bool operator > (const char* lhs, const string& rhs)
{
	return (rhs.compare(lhs) <= 0);
}

static inline bool operator > (const string& lhs, const char* rhs)
{
	return (lhs.compare(rhs) > 0);
}

static inline bool operator >= (const string& lhs, const string& rhs)
{
	return (lhs.compare(rhs) >= 0);
}

static inline bool operator >= (const char* lhs, const string& rhs)
{
	return (rhs.compare(lhs) < 0);
}

static inline bool operator >= (const string& lhs, const char* rhs)
{
	return (lhs.compare(rhs) >= 0);
}

} // namespace fbcstd

#endif // FBC_STL_STRING_HPP_
