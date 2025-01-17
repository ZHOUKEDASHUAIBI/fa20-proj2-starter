from unittest import TestCase
from framework import AssemblyTest, print_coverage


class TestAbs(TestCase):
    def test_zero(self):
        t = AssemblyTest(self, "abs.s")
        # load 0 into register a0
        t.input_scalar("a0", 0)
        # call the abs function
        t.call("abs")
        # check that after calling abs, a0 is equal to 0 (abs(0) = 0)
        t.check_scalar("a0", 0)
        # generate the `assembly/TestAbs_test_zero.s` file and run it through venus
        t.execute()

    def test_one(self):
        # same as test_zero, but with input 1
        t = AssemblyTest(self, "abs.s")
        t.input_scalar("a0", 1)
        t.call("abs")
        t.check_scalar("a0", 1)
        t.execute()

    @classmethod
    def tearDownClass(cls):
        print_coverage("abs.s", verbose=False)


class TestRelu(TestCase):
    def test_simple(self):
        t = AssemblyTest(self, "relu.s")
        # create an array in the data section
        array0 = t.array([-9, 162, 74, 33, 126, 22, -35, -258, -74, -2, -294, -118])
        # load address of `array0` into register a0
        t.input_array("a0", array0)
        # set a1 to the length of our array
        t.input_scalar("a1", len(array0))
        # call the relu function
        t.call("relu")
        # check that the array0 was changed appropriately
        t.check_array(array0, [0, 162, 74, 33, 126, 22, 0, 0, 0, 0, 0, 0])
        # generate the `assembly/TestRelu_test_simple.s` file and run it through venus
        t.execute()

    def test_all_0(self):               #array with all 0's
        t = AssemblyTest(self, "relu.s")
        array1 = t.array([0, 0, 0, 0, 0, 0, 0, 0, 0])
        t.input_array("a0", array1)
        t.input_scalar("a1", len(array1))
        t.call("relu")
        t.check_array(array1, [0, 0, 0, 0, 0, 0, 0, 0, 0])
        t.execute()

    def test_minus(self):               #array with all negative numbers
        t = AssemblyTest(self, "relu.s")
        array2 = t.array([-1, -6, -2, -9, -5, -1, -5, -4, -6, -7])
        t.input_array("a0", array2)
        t.input_scalar("a1", len(array2))
        t.call("relu")
        t.check_array(array2, [0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
        t.execute()

    def test_length_1_positive(self):   #array with one positive number
        t = AssemblyTest(self, "relu.s")
        array3 = t.array([1])
        t.input_array("a0", array3)
        t.input_scalar("a1", len(array3))
        t.call("relu")
        t.check_array(array3, [1])
        t.execute()

    def test_length_1_negaive(self):    #array with one negative number
        t = AssemblyTest(self, "relu.s")
        array4 = t.array([-1])
        t.input_array("a0", array4)
        t.input_scalar("a1", len(array4))
        t.call("relu")
        t.check_array(array4, [0])
        t.execute()
        
    def test_length_0(self):            #empty array
        t = AssemblyTest(self, "relu.s")
        array5 = t.array([])
        t.input_array("a0", array5)
        t.input_scalar("a1", len(array5))
        t.call("relu")
        t.execute(78)
        

    @classmethod
    def tearDownClass(cls):
        print_coverage("relu.s", verbose=False)


class TestArgmax(TestCase):
    def test_simple(self):
        t = AssemblyTest(self, "argmax.s")
        # create an array in the data section
        #raise NotImplementedError("TODO")
        # TODO
<<<<<<< HEAD
        array0 = t.array([-34, 884, -1076, 74, 394])
=======
        array0 = t.array([5, 1, 0, -6, 2, 9])
>>>>>>> 08c012d0e7787f0abbea6a1bb7b7bfeba487954b
        # load address of the array into register a0
        # TODO
        t.input_array("a0", array0)
        # set a1 to the length of the array
        # TODO
        t.input_scalar("a1", len(array0))
        # call the `argmax` function
        # TODO
        t.call("argmax")
        # check that the register a0 contains the correct output
        # TODO
<<<<<<< HEAD
        t.check_scalar("a0", 1)
=======
        t.check_scalar("a0", 5)
>>>>>>> 08c012d0e7787f0abbea6a1bb7b7bfeba487954b
        # generate the `assembly/TestArgmax_test_simple.s` file and run it through venus
        t.execute()

    def test_length_0(self):
        t = AssemblyTest(self, "argmax.s")
        array1 = t.array([])
        t.input_array("a0", array1)
        t.input_scalar("a1", len(array1))
        t.call("argmax")
        t.execute(77)

    @classmethod
    def tearDownClass(cls):
        print_coverage("argmax.s", verbose=False)


class TestDot(TestCase):
    def test_simple(self):
        t = AssemblyTest(self, "dot.s")
        # create arrays in the data section
        #raise NotImplementedError("TODO")
        # TODO
<<<<<<< HEAD
        array0 = t.array([9, -10, 11, -12])
        array1 = t.array([1, 2, 3, 4])
=======
        array0 = t.array([1, 2, 3, 4, 5, 6, 7, 8, 9])
        array1 = t.array([1, 2, 3, 4, 5, 6, 7, 8, 9])
>>>>>>> 08c012d0e7787f0abbea6a1bb7b7bfeba487954b
        # load array addresses into argument registers
        # TODO
        t.input_array("a0", array0)
        t.input_array("a1", array1)
        # load array attributes into argument registers
        # TODO
        t.input_scalar("a2", len(array0))
        t.input_scalar("a3", 1)
        t.input_scalar("a4", 1)
        # call the `dot` function
        t.call("dot")
        # check the return value
        # TODO
<<<<<<< HEAD
        t.check_scalar("a0", -26)
=======
        t.check_scalar("a0", 285)
>>>>>>> 08c012d0e7787f0abbea6a1bb7b7bfeba487954b
        t.execute()
    def test_length_0(self):
        t = AssemblyTest(self, "dot.s")
        array2 = t.array([])
        array3 = t.array([])
        t.input_array("a0", array2)
        t.input_array("a1", array3)
        t.input_scalar("a2", len(array2))
        t.input_scalar("a3", 1)
        t.input_scalar("a4", 1)
        t.call("dot")
        t.execute(75)
    def test_stride_0(self):
        t = AssemblyTest(self, "dot.s")
        array4 = t.array([1, 2, 3, 4, 5])
        array5 = t.array([1, 2, 3, 4, 5])
        t.input_array("a0", array4)
        t.input_array("a1", array5)
        t.input_scalar("a2", len(array4))
        t.input_scalar("a3", 1)
        t.input_scalar("a4", 0)
        t.call("dot")
        t.execute(76)
    def test_stride(self):
        t = AssemblyTest(self, "dot.s")
        array6 = t.array([1, 2, 3, 4, 5, 6, 7, 8, 9])
        array7 = t.array([1, 2, 3, 4, 5, 6, 7, 8, 9])
        t.input_array("a0", array6)
        t.input_array("a1", array7)
        t.input_scalar("a2", 3)
        t.input_scalar("a3", 1)
        t.input_scalar("a4", 2)
        t.call("dot")
        t.check_scalar("a0", 22)
        t.execute()
    
    @classmethod
    def tearDownClass(cls):
        print_coverage("dot.s", verbose=False)


class TestMatmul(TestCase):

    def do_matmul(self, m0, m0_rows, m0_cols, m1, m1_rows, m1_cols, result, code=0):
        t = AssemblyTest(self, "matmul.s")
        # we need to include (aka import) the dot.s file since it is used by matmul.s
        t.include("dot.s")

        # create arrays for the arguments and to store the result
        array0 = t.array(m0)
        array1 = t.array(m1)
        array_out = t.array([0] * len(result))

        # load address of input matrices and set their dimensions
        #raise NotImplementedError("TODO")
        # TODO
        t.input_array("a0", array0)
        t.input_scalar("a1", m0_rows)
        t.input_scalar("a2", m0_cols)
        t.input_array("a3", array1)
        t.input_scalar("a4", m1_rows)
        t.input_scalar("a5", m1_cols)
        # load address of output array
        # TODO
        t.input_array("a6", array_out)
        # call the matmul function
        t.call("matmul")

        # check the content of the output array
        # TODO
        t.check_array(array_out, result)
        # generate the assembly file and run it through venus, we expect the simulation to exit with code `code`
        t.execute(code=code)

    def test_simple(self):
        self.do_matmul(
            [11, -10, 13, 10, -23, -6, -22, 10], 4, 2,
            [1, 12, 4, 2, -3, -3], 2, 3,
            [-9, 162, 74, 33, 126, 22, -35, -258, -74, -2, -294, -118]
        )
    def test_error_72(self):
        self.do_matmul([1], -1, 1, [2], 1, 1, [2], 72)
        self.do_matmul([1], 1, -1, [2], 1, 1, [2], 72)
    
    def test_error_73(self):
        self.do_matmul([1], 1, 1, [2], -1, 1, [2], 73)
        self.do_matmul([1], 1, 1, [2], 1, -1, [2], 73)

    def test_error_74(self):
        self.do_matmul([1], 1, 1, [2, 3], 2, 1, [2], 74)
    @classmethod
    def tearDownClass(cls):
        print_coverage("matmul.s", verbose=False)


class TestReadMatrix(TestCase):

    def do_read_matrix(self, fail='', code=0):
        t = AssemblyTest(self, "read_matrix.s")
        # load address to the name of the input file into register a0
        t.input_read_filename("a0", "inputs/test_read_matrix/test_input.bin")

        # allocate space to hold the rows and cols output parameters
        rows = t.array([-1])
        cols = t.array([-1])

        # load the addresses to the output parameters into the argument registers
        #raise NotImplementedError("TODO")
        # TODO
        t.input_array("a1", rows)
        t.input_array("a2", cols)
        # call the read_matrix function
        t.call("read_matrix")

        # check the output from the function
        # TODO
        t.check_array_pointer("a0", [1, 2, 3, 4, 5, 6, 7, 8, 9])

        # generate assembly and run it through venus
        t.execute(fail=fail, code=code)

    def test_simple(self):
        self.do_read_matrix()
    def test_error_malloc(self):
        self.do_read_matrix(fail = 'malloc', code = 88)
    def test_error_fopen(self):
        self.do_read_matrix(fail = 'fopen', code = 90)
    def test_error_fread(self):
        self.do_read_matrix(fail = 'fread', code = 91)
    def test_error_fclose(self):
        self.do_read_matrix(fail = 'fclose', code = 92)

    @classmethod
    def tearDownClass(cls):
        print_coverage("read_matrix.s", verbose=False)


class TestWriteMatrix(TestCase):

    def do_write_matrix(self, fail='', code=0):
        t = AssemblyTest(self, "write_matrix.s")
        outfile = "outputs/test_write_matrix/student.bin"
        # load output file name into a0 register
        t.input_write_filename("a0", outfile)
        # load input array and other arguments
        #raise NotImplementedError("TODO")
        # TODO
        array0 = t.array([-34, 844, -1076, 74, 394])
        t.input_array("a1", array0)
        t.input_scalar("a2", 5)
        t.input_scalar("a3", 1)
        # call `write_matrix` function
        t.call("write_matrix")
        # generate assembly and run it through venus
        t.execute(fail=fail, code=code)
        # compare the output file against the reference
        if not fail:
            t.check_file_output(outfile, "outputs/test_write_matrix/reference.bin")

    def test_simple(self):
        self.do_write_matrix()
    def test_error_fopen(self):
        self.do_write_matrix(fail = 'fopen', code = 93)
    def test_error_fwrite(self):
        self.do_write_matrix(fail  = 'fwrite', code = 94)
    def test_error_fclose(self):
        self.do_write_matrix(fail = 'fclose', code = 95)
    @classmethod
    def tearDownClass(cls):
        print_coverage("write_matrix.s", verbose=False)


class TestClassify(TestCase):

    def make_test(self):
        t = AssemblyTest(self, "classify.s")
        t.include("argmax.s")
        t.include("dot.s")
        t.include("matmul.s")
        t.include("read_matrix.s")
        t.include("relu.s")
        t.include("write_matrix.s")
        return t

    def test_simple0_input0(self):
        t = self.make_test()
        out_file = "outputs/test_basic_main/student0.bin"
        ref_file = "outputs/test_basic_main/reference0.bin"
        args = ["inputs/simple0/bin/m0.bin", "inputs/simple0/bin/m1.bin",
                "inputs/simple0/bin/inputs/input0.bin", out_file]
        # call classify function
        t.call("classify")
        # generate assembly and pass program arguments directly to venus
        t.execute(args=args)

        # compare the output file and
        #raise NotImplementedError("TODO")
        # TODO
        # compare the classification output with `check_stdout`
        t.check_file_output(out_file, ref_file)
        t.check_stdout("2")

    @classmethod
    def tearDownClass(cls):
        print_coverage("classify.s", verbose=False)


class TestMain(TestCase):

    def run_main(self, inputs, output_id, label):
        args = [f"{inputs}/m0.bin", f"{inputs}/m1.bin", f"{inputs}/inputs/input0.bin",
                f"outputs/test_basic_main/student{output_id}.bin"]
        reference = f"outputs/test_basic_main/reference{output_id}.bin"
        t = AssemblyTest(self, "main.s", no_utils=True)
        t.call("main")
        t.execute(args=args, verbose=False)
        t.check_stdout(label)
        t.check_file_output(args[-1], reference)

    def test0(self):
        self.run_main("inputs/simple0/bin", "0", "2")

    def test1(self):
        self.run_main("inputs/simple1/bin", "1", "1")
    
    def test2(self):
        self.run_main("inputs/simple2/bin", "2", "7")
