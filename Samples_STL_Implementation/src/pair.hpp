#ifndef FBC_STL_PAIR_HPP_
#define FBC_STL_PAIR_HPP_

// blog: https://blog.csdn.net/fengbingchun/article/details/81022029

namespace fbcstd {

template<class T1, class T2>
struct pair {
	typedef T1 first_type;
	typedef T2 second_type;

	// default construct
	pair() : first(), second() {}
	// construct from compatible pair
	template<class U, class V>
	pair(const pair<U,V>& pr) : first(pr.first), second(pr.second) {}
	// construct from specified values
	pair(const first_type& a, const second_type& b) : first(a), second(b) {}

	// assign from copied pair
	pair& operator = (const pair& pr) 
	{
		first = pr.first;
		second = pr.second;

		return (*this);
	}

	T1 first;
	T2 second;
}; // struct pair

// relational operators for pair
template<class T1, class T2>
inline bool operator == (const pair<T1, T2>& lhs, const pair<T1, T2>& rhs)
{
	return (lhs.first == rhs.first && lhs.second == rhs.second);
}

template<class T1, class T2>
inline bool operator != (const pair<T1, T2>& lhs, const pair<T1, T2>& rhs)
{
	return (!(lhs == rhs));
}

template<class T1, class T2>
inline bool operator < (const pair<T1, T2>& lhs, const pair<T1, T2>& rhs)
{
	return (lhs.first < rhs.first || (!(rhs.first < lhs.first) && lhs.second < rhs.second));
}

template<class T1, class T2>
inline bool operator > (const pair<T1, T2>& lhs, const pair<T1, T2>& rhs)
{
	return (rhs < lhs);
}

template<class T1, class T2>
inline bool operator <= (const pair<T1, T2>& lhs, const pair<T1, T2>& rhs)
{
	return (!(rhs < lhs));
}

template<class T1, class T2>
inline bool operator >= (const pair<T1, T2>& lhs, const pair<T1, T2>& rhs)
{
	return (!(lhs < rhs));
}

} // namespace fbcstd

#endif // FBC_STL_PAIR_HPP_
