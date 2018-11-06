# Create Y chromosome SNP positiions for Battenberg

system("wget http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chrY.phase3_integrated_v2a.20130502.genotypes.vcf.gz", wait=T)

dat = read.table("ALL.chrY.phase3_integrated_v2a.20130502.genotypes.vcf.gz", header=F, sep="\t", stringsAsFactors=F)
dat = dat[,c(1,2,4,5)]
colnames(dat) = c("chromosome", "position", "ref", "alt")
dat = dat[apply(dat, 1, function(x) nchar(x["ref"])==1 & nchar(x["ref"])!="-" & nchar(x["alt"])==1 & nchar(x["alt"])!="-"),]

nucleotides = 1:4
names(nucleotides) = c("A", "C", "G", "T")

dat$a0 = as.numeric(nucleotides[dat$ref])
dat$a1 = as.numeric(nucleotides[dat$alt])

write.table(dat[,c("chromosome", "position")], file="1000genomesloci2012_chr24.txt", quote=F, row.names=F, sep="\t", col.names=F)
write.table(dat[,c("position", "a0", "a1")], file="1000genomesAlleles2012_chr24.txt", quote=F, row.names=F, sep="\t", col.names=T)
