#define MAXN 500
#define MAXM 500
unsigned int n = 0, m = 0;
typedef unsigned int pixel;
pixel img[MAXN * MAXM];
pixel result_img[MAXN * MAXM];
//--------------------------------------- TODO: FILL IN YOUR FILE PATH ---------------------------------------------
char read_path[] = "/home/your_user_name/yao-archlab-s21/lab1/sample/gauss.pixel";
char write_path[] = "your/path/to/output/file";
//------------------------------------------------------------------------------------------------------------------

void _printf_num(int num);
void _printf_char(char ch);
void _read_int(char* file_name, int* byte_address, int length);
void _write_int(char* file_name, int* byte_address, int length) ;
void _return();
void image_process();
void image_input();
void image_output();
void image_to_file();

int main() {
    image_input();
    image_process();
    image_output();
    image_to_file();
    _return();
}

void _printf_num(int num) {
    // DO NOT MODIFY THIS!!!
    __asm__ __volatile__ (
        "li a7, 1\n\t"
        "mv a0, %[print_num]\n\t"
        "ecall \n\t"
        : /* no output*/
        : [print_num]"r"(num)
        : "a0", "a7"
    );
}

void _printf_char(char ch) {
    // DO NOT MODIFY THIS!!!
    __asm__ __volatile__ (
        "li a7, 11\n\t"
        "mv a0, %[print_num]\n\t"
        "ecall \n\t"
        : /* no output*/
        : [print_num]"r"(ch)
        : "a0", "a7"
    );
}

void _return() {
    // DO NOT MODIFY THIS!!!
    __asm__ __volatile__ (
        "li a7, 10\n\t"
        "ecall\n\t"
        : /* no output*/
        : /* no input */
        : "a7"
    );
}

void _read_int(char* file_name, int* byte_address, int length) {
    // DO NOT MODIFY THIS!!!
    __asm__ __volatile__ (
        "li a7, 1024\n\t"
        "li a1, 0\n\t"
        "ecall\n\t"
        "mv t3, a0\n\t"
        "li a7, 65\n\t"
        "mv a1, %[addr]\n\t"
        "mv a2, %[len]\n\t"
        "ecall\n\t"
        "li a7, 57\n\t"
        "mv a0, t3\n\t"
        "ecall\n\t"
        : /*no output*/
        : [addr]"r"(byte_address), [len]"r"(length)
        : "a0", "a1", "a2", "t3", "a7"
    );
}

void _write_int(char* file_name, int* byte_address, int length) {
    // DO NOT MODIFY THIS!!!
    __asm__ __volatile__ (
        "li a7, 1024\n\t"
        "li a1, 1\n\t"
        "ecall\n\t"
        "mv t3, a0\n\t"
        "li a7, 66\n\t"
        "mv a1, %[addr]\n\t"
        "mv a2, %[len]\n\t"
        "ecall\n\t"
        "li a7, 57\n\t"
        "mv a0, t3\n\t"
        "ecall\n\t"
        : /*no output*/
        : [addr]"r"(byte_address), [len]"r"(length)
        : "a0", "a1", "a2", "t3", "a7"
    );
}


void image_process() {
    //--------------------------------------- TODO: FILL IN CODE HERE ---------------------------------------
    // Image border (first and last row, column) is not considered.
    // The input data is in img[]. The output data should be in result_img[].

    return;
    //-------------------------------------------------------------------------------------------------------
}

void image_input() {
    // DO NOT MODIFY THIS!!!
    int data[MAXN * MAXM + 2];
    _read_int(read_path, data, MAXN * MAXM + 2);
    n = data[0];
    m = data[1];
    for (int i = 0; i < n * m; ++i) {
        img[i] = data[2 + i];
    }
}

void image_output() {
    // DO NOT MODIFY THIS!!!
    _printf_num(n);
    _printf_char(' ');
    _printf_num(m);
    _printf_char('\n');
    for (int i = 0; i < n * m; ++i) {
        _printf_num(result_img[i]); 
        _printf_char(' ');
    }
}

void image_to_file() {
    // DO NOT MODIFY THIS!!!
    int data[MAXN * MAXM + 2];
    data[0] = n;
    data[1] = m;
    for (int i = 0; i < n * m; ++i) {
        data[2 + i] = result_img[i]; 
    }
    _write_int(write_path, data, n * m + 2);
}