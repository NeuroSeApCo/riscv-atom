#include <stdlib.h>
#include <iostream>
#include <iomanip>
#include <fstream>
#include <unistd.h>
#include <string>
#include <vector>


// Definitions
const unsigned int Sec = 1000000;	// microseconds in 1s
const unsigned int mSec = 1000;		// mictoseconds in 1ms

// Simulation Parameters
unsigned int delay_amt = 100 * mSec; //default 

// This is used to display reason for simulation termination
std::string end_simulation_reason;

#include "defs.hpp"
#include "backend.hpp"

// Global flags
bool verbose_flag = false;
bool debug_mode = false;
bool trace_enabled = false;

// Input file
std::string ifile = "";

// Trace directory
std::string trace_dir;

/**
 * @brief parses command line arguments given to the assembler and 
 * accordingly sets appropriate internal flags/variables and/or displays 
 * info messages.
 * 
 * @param argc argument count
 * @param argv argument vector
 * @return true if we need to exit after this step
 * @return false otherwise
 */
bool parse_commandline_args(const int argc, char**argv)
{
    // ============= STEP-2: PARSE COMMAND-LINE ARGUMENTS ================
    if(argc < 2)
    {
        std::cerr << "!Error: too few arguments\n For help, try : atomsim --help\n";
        return true;
    }
    int i = 1;
    while(i < argc)
    {
        std::string argument = argv[i];

        // check if it is a flag
        if(argument[0] == '-')
        {
            if(argument == "-v")
            {
				// turn on verbose
                verbose_flag = true;
                i++;
            }
			else if(argument == "-d")
            {
				// run in debug mode
                debug_mode = true;
                i++;
            }
            else if(argument == "-h")
            {
				// show short help message
                std::cout << Info_short_help_msg;
                return true;
            }
			else if(argument == "--trace-dir")
            {
				// print long help message
                if(i == argc-1)
				{
					std::cerr << "!Error: Trace directory not provided\n";
                	return true;
				}
				i++;
				trace_dir = argv[i];
				i++;
            }
            else if(argument == "--help")
            {
				// print long help message
                std::cout << Info_long_help_msg;
                return true;
            }
            else if(argument == "--version")
            {
				// print charon version info
                std::cout << Info_version << std::endl << Info_copyright;
                return true;
            }
            else
            {
                std::cerr << "!Error: Unknown argument: " << argument << "\n";
                return true;
            }
        }
        else
        {
            // specify input files
            if(ifile != "")
            {
                std::cerr << "!ERROR: Multiple Input files povided\n";
                return true;
            }
            else
                ifile = argument;
            i++;
        }
    }

	if (ifile == "")
	{
		// No input file povided
		std::cerr << "!ERROR: No input file povided\n";
		return true;
	}
    return false;
}

/**
 * @brief Run specified cycles of simulation
 * 
 * @param cycles no to cycles to run for
 * @param b pointer to backend object
 */
void tick(long unsigned int cycles, Backend * b)
{
	for(long unsigned int i=0; i<cycles && !b->done(); i++)
	{
		if(b->done())
		{
			break;
		}
	 	b->refreshData();
	 	b->displayData();
	 	b->tick();
	}
}


/**
 * @brief Main function
 * 
 * @param argc Argument count
 * @param argv Argument vector
 * @return int exit code
 */
int main(int argc, char **argv)
{
	// Parse commandline arguments
	if(parse_commandline_args(argc, argv))
		return 0;
	
	// Display Atomsim banner
	std::cout << "|=================================================== \n";
	std::cout << "|                   AtomSim v1.0\n";
	std::cout << "|=================================================== \n\n";
	std::cout << "  Author : Saurabh Singh (saurabh.s99100@gmail.com)\n\n";
	std::cout << "  File : "<< ifile <<"      Ready...\n\n";

	// Initialize verilator
	Verilated::commandArgs(argc, argv);

	// Create a new backend instance
	Backend bkend(ifile);

	// Run simulation
	if(debug_mode)
	{
		std::string input;
		while(true)
		{
			if(bkend.done())	// if $finish encountered by verilator
			{
				end_simulation_reason = "Backend encountered a $finish";
				break;
			}

			// Parse Input
			std::cout << ": ";
			getline(std::cin, input);
			
			// Tokenize
			std::vector<std::string> token;
			tokenize(input, token, ' ');

			// Parse Command
			if(token[0] == "q" | token[0] == "quit")
			{
				// Quit simulator
				end_simulation_reason = "User interruption";
				break;
			}
			else if(token[0] == "r")
			{
				// Run indefinitely
				tick(-1, &bkend);
			}
			else if(token[0] == "rst")
			{
				// Reset Simulator
				bkend.reset();
			}
			else if(token[0] == "")
			{
				// Run for 2 cycles
				tick(2, &bkend);
			}
			else if(token[0] == "run")
			{
				// run for specified cycles
				if(token.size()<2)
					std::cout << "!ERROR: run expects one argument" <<"\n";
				else
					tick(std::stoi(token[1]), &bkend);
			}
			else if(token[0] == "trace")
			{
				// Enable trace
				if(token.size()<2)
					std::cout << "!ERROR: trace command expects a filename" <<"\n";
				else
				{
					if(trace_enabled == false)
					{
						std::string tracefile = trace_dir+"/"+token[1];
						bkend.tb->openTrace(tracefile.c_str());
						std::cout << "Trace enabled : \"" << tracefile << "\" opened for output.\n";
						trace_enabled = true;
					}
					else
						std::cout << "Trace was already enabled\n";
				}
			}
			else if(token[0] == "notrace")
			{
				// Disable trace
				if(trace_enabled == true)
				{
					bkend.tb->closeTrace();
					std::cout << "Trace disabled\n";
					trace_enabled = false;
				}
				else
					std::cout << "Trace was not enabled \n";
			}
			else
			{
				std::cout << "!ERROR: Unknown command" <<"\n";
			}
			input.clear();
		}
	}
	else
	{
		tick(-1, &bkend);
	}

	if(trace_enabled) // if trace file is open, close it before exiting
		bkend.tb->closeTrace();
	
	std::cout << "Simulation ended @ tick " << bkend.tb->m_tickcount_total << " due to : " << end_simulation_reason << std::endl;
	exit(EXIT_SUCCESS);    
}


