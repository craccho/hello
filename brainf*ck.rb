#!/usr/bin/env ruby

unless ARGV[0]
    puts "usage: ruby brainf*ck.rb [source file]"
    exit
end

def read_source_char
    open ARGV[0],"r" do |f|
        while c = f.getc()
            yield c
        end
    end
end

source = ""

read_source_char() do |char|
    case char
    when ?>
        source << "ptr += 1\n"
    when ?<
        source << "ptr -= 1\n"
    when ?+
        source << "data[ptr] += 1\n"
    when ?-
        source << "data[ptr] -= 1\n"
    when ?.
        source << "putc data[ptr]\n"
    when ?,
        source << "data[ptr] = STDIN.getc()\n"
    when ?[
        source << "while data[ptr] != 0\n"
    when ?]
        source << "end\n"
    end
end

ptr = 0; data = (1..1000).map{|_|0}; l = 0
eval(source) rescue exit
