#!/usr/bin/perl

use strict;
use warnings;

sub Open_File {
    # Argumments passed to the function.
    my ($filename) = @_;

    # Open the file that we want to work with.
    open(my $in, "<", $filename) or die "Could not open '$filename': $!";

    # Reading the file content into a scalar var.
    my $content = do {local $/; <$in>};

    # Close the file handler.
    close($in);

    Word_freq($content);

}

sub Manipulate_text_write_file {

    # Argumments passed to the function.
    my ($word_count) = @_;

    # File name and opening the file where we will be writing.
    my $filename = "wordfrq.txt";

    open(my $op, ">", $filename) or die "Could not open '$filename' for writing: $!";

    # Sorting the has table in a descending order based on the key value.
    my @sorted_word_count_table = sort { $$word_count{$b} <=> $$word_count{$a} } keys %$word_count;

    # Write the sorted table in the .txt file.
    foreach my $key (@sorted_word_count_table){
        print $op "$key: $$word_count{$key}\n";
    }

    # Calculate the total number of words.
    my $total_words = 0;

    foreach my $count (values %$word_count){
        $total_words += $count;
    }

    #Write the total number of words in the txt file.
    print $op "TOTAL WORDS: $total_words\n";

    # Close the file handler.
    close($op);
}

sub Word_freq {
    # Argumments passed to the function.
    my($content) = @_;

    # Creating a hash table.
    my %word_count;

    # Tokanize the words from the file, using regular expresion.
    my @words = $content =~ /[^\p{P}\s]+/g;

    # Count each word adding the new words as keys and increasing the values of the words that are already in the dictionary.
    foreach my $word (@words){

        $word_count{$word}++;
    }

    Manipulate_text_write_file (\%word_count);
}

sub main {

    my $filename = "THE SONNETS.txt";
    Open_File($filename);
    print "Process complete!\n";
}

if ($0 eq __FILE__){
    main();
}