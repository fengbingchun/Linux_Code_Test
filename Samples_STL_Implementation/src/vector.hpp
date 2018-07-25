#ifndef FBC_STL_VECTOR_HPP_
#define FBC_STL_VECTOR_HPP_

// blog: https://blog.csdn.net/fengbingchun/article/details/81210996

#include <stdlib.h>

namespace fbcstd {

template<class T>
class vector {
public:
	typedef size_t size_type;
	typedef T value_type;
	typedef T* iterator;
	typedef const T* const_iterator;

	vector();
	vector(size_type n, const value_type& val = value_type());
	vector(const vector& x);
	~vector();

	void reserve(size_type n);
	size_type capacity() const;
	size_type size() const;
	bool empty() const;

	value_type* data();
	const value_type* data() const;

	value_type& at(size_type n);
	const value_type& at(size_type n) const;
	value_type& operator [] (size_type n);
	const value_type& operator [] (size_type n) const;
	vector& operator = (const vector& x);

	void clear();
	value_type& back();
	const value_type& back() const;
	value_type& front();
	const value_type& front() const;

	void push_back(const value_type& val);
	void pop_back();

	void resize(size_type n, value_type val = value_type());

	iterator begin();
	const_iterator begin() const;
	iterator end();
	const_iterator end() const;

private:
	size_type size_ = 0;
	size_type capacity_ = 0; // 2^n
	value_type* buffer_ = nullptr;

}; // class vector

template<class T> inline
vector<T>::vector() : size_(0), capacity_(0), buffer_(nullptr)
{
}

template<class T> inline
vector<T>::vector(size_type n, const value_type& val)
{
	reserve(n);
	
	size_ = n;
	for (size_t i = 0; i < n; ++i)
		buffer_[i] = val;
}

template<class T> inline
vector<T>::vector(const vector& x)
{
	reserve(x.size_);

	size_ = x.size_;
	for (size_t i = 0; i < x.size_; ++i)
		buffer_[i] = x.buffer_[i];
}

template<class T> inline
vector<T>::~vector()
{
	if (buffer_)
		delete [] buffer_;
}

template<class T> inline
void vector<T>::reserve(size_type n)
{
	if (capacity_ < n) {
		delete [] buffer_;

		capacity_ = 1;
		if (capacity_ < n) {
			capacity_ = 2;
			while (capacity_ < n) {		
				capacity_ *= 2;
			}
		}
		buffer_ = new value_type[capacity_];
	}
}

template<class T> inline
size_t vector<T>::capacity() const
{
	return capacity_;
}

template<class T> inline
size_t vector<T>::size() const
{
	return size_;
}

template<class T> inline
bool vector<T>::empty() const
{
	return size_ == 0 ? true : false;
}

template<class T> inline
T* vector<T>::data()
{
	return buffer_;
}

template<class T> inline
const T* vector<T>::data() const
{
	return buffer_;
}
	
template<class T> inline
T& vector<T>::at(size_type n)
{
	if (size_ <= n) abort();
	return buffer_[n];
}

template<class T> inline
const T& vector<T>::at(size_type n) const
{
	if (size_ <= n) abort();
	return buffer_[n];
}

template<class T> inline
T& vector<T>::operator [] (size_type n)
{
	if (size_ <= n) abort();
	return buffer_[n];
}

template<class T> inline
const T& vector<T>::operator [] (size_type n) const
{
	if (size_ <= n) abort();
	return buffer_[n];
}

template<class T> inline
vector<T>& vector<T>::operator = (const vector& x)
{
	reserve(x.size_);

	size_ = x.size_;
	for (size_t i = 0; i < size_; ++i)
		buffer_[i] = x.buffer_[i];

	return *this;
}

template<class T> inline
void vector<T>::clear()
{
	size_ = 0;
}

template<class T> inline	
T& vector<T>::back()
{
	if (size_ == 0) abort();
	return buffer_[size_-1];
}

template<class T> inline
const T& vector<T>::back() const
{
	if (size_ == 0) abort();
	return buffer_[size_-1];
}

template<class T> inline	
T& vector<T>::front()
{
	if (size_ == 0) abort();
	return buffer_[0];
}

template<class T> inline
const T& vector<T>::front() const
{
	if (size_ == 0) abort();
	return buffer_[0];
}

template<class T> inline
void vector<T>::push_back(const value_type& val)
{
	if (size_ >= capacity_) {
		T* tmp = new T[size_];
		for (size_t i = 0; i < size_; ++i)
			tmp[i] = buffer_[i];

		reserve(size_+1);

		for (size_t i = 0; i < size_; ++i)
			buffer_[i] = tmp[i];

		delete [] tmp;
	}

	buffer_[size_] = val;
	size_ += 1;
}

template<class T> inline
void vector<T>::pop_back()
{
	if (size_ == 0) abort();
	--size_;
}

template<class T> inline
void vector<T>::resize(size_type n, value_type val)
{
	if (size_ < n) {
		if (n > capacity_) {
			T* tmp = new T[size_];
			for (size_t i = 0; i < size_; ++i)
				tmp[i] = buffer_[i];

			reserve(n);

			for (size_t i = 0; i < size_; ++i)
				buffer_[i] = tmp[i];

			delete [] tmp;
		}

		for (size_t i = size_; i < n; ++i)
			buffer_[i] = val;
	}

	size_ = n;
}

template<class T> inline
T* vector<T>::begin()
{
	return buffer_;
}

template<class T> inline
const T* vector<T>::begin() const
{
	return buffer_;
}

template<class T> inline
T* vector<T>::end()
{
	return buffer_ + size_;
}

template<class T> inline
const T* vector<T>::end() const
{
	return buffer_ + size_;
}

template<class T> static inline
bool operator == (const vector<T>& lhs, const vector<T>& rhs)
{
	if (lhs.size() != rhs.size())
		return false;

	for (size_t i = 0; i < lhs.size(); ++i)	{
		if (lhs[i] != rhs[i])
			return false;
	}

	return true;
}

template<class T> static inline
bool operator != (const vector<T>& lhs, const vector<T>& rhs)
{
	return !(lhs == rhs);
}

template<class T> static inline
bool operator < (const vector<T>& lhs, const vector<T>& rhs)
{
	bool flag = true;
	if (lhs.size() == rhs.size()) {
		if (lhs == rhs) {
			flag = false;
		} else {
			for (size_t i = 0; i < lhs.size(); ++i) {
				if (lhs[i] > rhs[i]) {
					flag = false;
					break;
				}
			}
		}
	} else if (lhs.size() < rhs.size()) {
		vector<T> vec(lhs.size());
		for (size_t i = 0; i < lhs.size(); ++i)
			vec[i] = rhs[i];

		if (lhs == vec) {
			flag = true;
		} else {
			for (size_t i = 0; i < lhs.size(); ++i) {
				if (lhs[i] > rhs[i]) {
					flag = false;
					break;
				}
			}
		}
	} else {
		vector<T> vec(rhs.size());
		for (size_t i = 0; i < rhs.size(); ++i)
			vec[i] = lhs[i];

		if (vec == rhs) {
			flag = false;
		} else {
			for (size_t i = 0; i < rhs.size(); ++i) {
				if (lhs[i] > rhs[i]) {
					flag = false;
					break;
				}
			}
		}
	}

	return flag;
}

template<class T> static inline
bool operator <= (const vector<T>& lhs, const vector<T>& rhs)
{
	return !(rhs < lhs);
}

template<class T> static inline
bool operator > (const vector<T>& lhs, const vector<T>& rhs)
{
	return (rhs < lhs);
}

template<class T> static inline
bool operator >= (const vector<T>& lhs, const vector<T>& rhs)
{
	return !(lhs < rhs);
}

} // namespace fbcstd

#endif // FBC_STL_VECTOR_HPP_ 
