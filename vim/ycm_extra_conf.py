# Based on the ycmd extra conf, but written from scratch
# All wrongs reversed

import os
import ycm_core

# Support C, C++ separately

# Common flags
common_flags = ['-Wall',
                '-Wextra',
                '-Werror',
                '-I', '.',
                '-I',
                '-isystem', '/usr/include',
                '-isystem', '/usr/local/include']

# C flags
c_flags = ['-std=c99',
           '-x', 'c']

# Need to add standard libraries here
cpp_flags = ['-std=c++11',
             '-x', 'c++',
             '-fno-exceptions',
             '-isystem',
             '/usr/lib/gcc/x86_64-pc-linux-gnu/4.9.3/include/g++-v4',
             '-isystem',
             '/usr/lib/gcc/x86_64-pc-linux-gnu/4.9.3/include/g++-v4/'
             + 'x86_64-pc-linux-gnu',
             '-isystem',
             '/usr/lib/gcc/x86_64-pc-linux-gnu/4.9.3/include/g++-v4/backward']


# Do we have additional flags?
try:
    custom_flags
except NameError:
    # No custom flags
    custom_flags = []

# Do we have custom project root?
try:
    project_root
except NameError:
    # Try current working dir
    project_root = os.getcwd()

# Do we have a compilation database specified?
try:
    if os.path.exists(compilation_database_dir):
        database = ycm_core.CompilationDatabase(compilation_database_dir)
    else:
        database = None
except NameError:
    # compilation_database_dir wasn't defined
    database = None


c_sources = ['.c']
c_headers = ['.h']

cpp_sources = ['.cpp', '.cc', '.cxx', '.C', '.c++']
cpp_headers = ['.hpp', '.hh', '.hxx', '.H', '.h++', '.h']

# Absolutify after these
path_flag_names = ['-isystem', '-I', '-iquote', '--sysroot=']


def this_script_dir():
    return os.path.dirname(os.path.abspath(__file__))


def make_absolute_paths(flags, working_directory):
    if not working_directory:
        # Nothing to make these based on
        return list(flags)

    new_flags = []
    make_next_absolute = False

    for flag in flags:
        new_flag = flag

        if make_next_absolute:
            make_next_absolute = False

            # If the path isn't absolute...
            if not flag.startswith('/'):
                # Make it absolute
                new_flag = os.path.join(working_directory, flag)

        # If the current flag is in path_flag_names...
        if flag in path_flag_names:
            # Mark next as to-be-absolutified
            make_next_absolute = True
        else:
            for path_flag in path_flag_names:
                # If it begins with a path flag (say, --sysroot=)...
                if flag.startswith(path_flag):
                    # Slice the end past the =
                    path = flag[len(path_flag):]
                    # Rejoin flag
                    new_flag = path_flag + os.path.join(working_directory,
                                                        path)
                    break

        if new_flag:
            new_flags.append(new_flag)
        else:
            # Just carry current one
            new_flags.append(flag)

    # Finally, return
    return new_flags


def is_header(filename):
    extension = os.path.splitext(filename)[1]
    if extension in cpp_headers or extension in c_headers:
        return True
    return False


def get_lang(filename):
    extension = os.path.splitext(filename)[1]
    # .h can be either....
    if extension in cpp_headers or extension in cpp_sources:
        return "C++"
    if extension in c_headers or extension in c_sources:
        return "C"
    return None


def search_ext_list(ext_list, filename):
    basename = os.path.splitext(filename)[0]

    for ext in ext_list:
        replacement_file = basename + ext
        if os.path.exists(replacement_file):
            compilation_info = database.GetCompilationInfoForFile(
                replacement_file)
            if compilation_info and compilation_info.compiler_flags:
                return compilation_info
    return None


# For when we have a database but it doesn't have header info
def get_compilation_info(filename):
    if database:
        compilation_info = database.GetCompilationInfoForFile(filename)
        if compilation_info and compilation_info.compiler_flags:
            return compilation_info
        else:
            if is_header(filename):
                res = search_ext_list(cpp_sources)
                if res is None:
                    res = search_ext_list(c_sources)
                return res
    return None


def FlagsForFile(filename, **kwargs):
    compilation_info = get_compilation_info(filename)

    if compilation_info is not None:
        # Absolutify paths
        ret_flags = make_absolute_paths(compilation_info.compiler_flags,
                                        compilation_info.compiler_working_dir)
    else:
        lang = get_lang(filename)
        flags = []
        if lang == "C":
            flags.extend(common_flags)
            flags.extend(c_flags)
            flags.extend(custom_flags)
        elif lang == "C++":
            flags.extend(common_flags)
            flags.extend(cpp_flags)
            flags.extend(custom_flags)
        else:
            # We don't have flags for this!
            return None

        # See MUCH higher for project_root
        ret_flags = make_absolute_paths(flags, project_root)

    return {
        'flags': ret_flags,
        'do_cache': True
    }
