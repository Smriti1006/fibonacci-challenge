# fibonacci-challenge

This project is a small application that calculates fibonacci series upto Uint64 max value.
After calculating next number in series, the program sleep for 1 second so that UI update is not very fast for end user.
Also tuples are being used for storing recursive values of series, i.e.
(a &+ b, a) is similar to f(n-1)+f(n-2).

The calculation happens on background thread and UItextview is being updated on main thread.