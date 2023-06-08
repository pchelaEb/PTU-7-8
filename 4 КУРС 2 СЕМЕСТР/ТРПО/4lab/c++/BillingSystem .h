#ifndef BillingSystem _h
#define BillingSystem _h


class BillingSystem  {

 public:

    virtual void bill(void  client, void  course)  = 0;

public:
    // virtual destructor for interface 
    virtual ~BillingSystem () { }

};

#endif // BillingSystem _h
