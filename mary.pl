use warnings;

my $keywords = ("é|são|era|eram|importante");
my $conjuncoes = ("nem|mas também|como também|além de|tanto quanto|bem como");
my $preposicoes = ("a|ante|até|após|com|contra|de|desde|em|entre|para|per|perante|por|sem|sob|sobre|trás|que");
my $artigos = ("do|da|dos|das|no|na|nos|nas|ao|à|aos|às|a|pelo|pela|pelos|pelas|por|o|dum|duma|duns|dumas|num|numa|nuns|numas");
my $paragrafo;
my @frases;
my @resumo;
my @palavras;
my @palavras_consideraveis;
my %hash;
my @ranking_palavras;
my $palavra_frequente;

open( FILE, "<texto" ) or die("Nao foi possivel abrir arquivo!");

while($paragrafo = <FILE>){
	@palavras = split(/[\s+]/, $paragrafo);
	
	foreach(@palavras){
		if(($_ =~ /\b(\w+)\b/) && ($1 !~ /\d/) && (length($1) >= 5)){
			push(@palavras_consideraveis, lc($_));
		}
	}
}

foreach(@palavras_consideraveis){
	$hash{lc $_}++;
}

foreach(sort {$hash{$b} <=> $hash{$a}} keys %hash) {
    push(@ranking_palavras, $_);
}

$palavra_frequente = shift(@ranking_palavras);

seek(FILE, 0, 0);

while($paragrafo = <FILE>){
  @frases = split(/\./, $paragrafo);
  
  foreach(@frases){
    if(($_ =~ /\b$keywords\b/i) && ($_ =~ /\b$palavra_frequente\b/i)){
      $_ .= ". ";
      push(@resumo, $_);
    }
  }
}

close(FILE);

print"Palavra frequente do texto: $palavra_frequente\n";

open(OUT, ">resumo") or die("Nao pode criar");

foreach(@resumo){
	print(OUT "$_");
}

close(OUT);
