CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'



# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests

set -e

# Step 2

if [[ -f `find student-submission/ListExamples.java` ]]
then 
    echo "File submitted successfully"
else 
    echo "Please make sure your file exists and is of the right format."
    exit
fi 

# Step 3

cp -r student-submission/ grading-area
cp TestListExamples.java grading-area
cp -r lib grading-area

# Step 4

set +e
cd grading-area
javac -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar *.java

if [[ $? == 0 ]]
then
    echo "Your code compiled!"
else
    echo "Your code did not compile. Please check it again."
fi

# Step 5

java -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar org.junit.runner.JUnitCore TestListExamples >out.txt
#redirects the output and error into out.txt

if [[ `grep -i 'OK' out.txt` == 'OK'* ]]
then
    echo "Score 100"
elif [[ `grep -i 'FAILURES!!!' out.txt` == 'FAILURES!!!'* ]]
then
    echo "Score 0"
fi




