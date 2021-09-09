1.值传递： 不可以。值传递后在调用函数后会有另一个unique_ptr指向原unique_ptr指向的对象，而不会有两个unique_ptr拥有相同的对象，故原unique_ptr变为空指针。 或者，使用如下方法： unique_ptr func2(unique_ptr up){ cout<<*up<<endl; return up; }

//使用up作为参数 unique_ptr up(new int(10));

//暂时转移所有权，函数结束时返回拷贝，重新收回所有权 up = func2(unique_ptr (up.release())); //up.release() ：up放弃对它所指对象的控制权，并返回保存的指针，将up置为空，不会释放内存 //如果不用up重新接受func2的返回值，这块内存就泄漏了

2.引用传递： 可以。不拷贝/复制，不涉及所有权的转移。 例： void func1(unique_ptr &up){ cout<<*up<<endl; }

unique_ptr up(new int(10));

func1(up);