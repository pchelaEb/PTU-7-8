#ifndef Manager_h
#define Manager_h

class BillingSystem ;
class Course;

class Manager {

 public:

    virtual void addCourse(void  client, void  course);

 public:



    /**
     * @element-type BillingSystem 
     */
    BillingSystem  *myBillingSystem ;

    /**
     * @element-type Course
     */
    Course *myCourse;

};

#endif // Manager_h
