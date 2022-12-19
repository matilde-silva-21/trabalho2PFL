
countNumber(_, 8).

countNumber(Count, Index) :- 
    Count is Count+1,
    New is Index+1, 
    countNumber(Count, New).
