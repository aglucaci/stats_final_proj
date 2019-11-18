
# Step-by-Step

(1) Unzip LANL Dataset HIVDB-2017-DNA.tgz <br>
.... (1a) We will use data from folder: HIV1-2017-Filtered <br>
.... (1b) Avoid the file "FLTHIV1COMPLETE2017DNA.fasta" as we want to use data separated according to individual genes. <br>
(2) Git clone hyphy (https://github.com/veg/hyphy) <br>
(3) Git clone hyphy-standalone-analyses (https://github.com/veg/hyphy-analyses) <br>
(4) Data cleanup.. Codon aware MSA (https://github.com/veg/hyphy-analyses/tree/master/codon-msa) <br>
.... (4a) For Protein MSA, used MAFFT (https://mafft.cbrc.jp/alignment/software/). <br>
(5) Seaview, for NJ Tree (http://doua.prabi.fr/software/seaview) <br>
(6) Run FUBAR <br>
(7) Run MEME <br>
(8) Exploratory Data Analysis (EDA) on LANL data. <br>
(9) HyPhy Vision (http://vision.hyphy.org/) to see the .json files <br>
(10) ??? <br>

# References
1. "HyPhy: hypothesis testing using phylogenies", https://www.ncbi.nlm.nih.gov/pubmed/15509596 <br>
2. "FUBAR: A Fast, Unconstrained Bayesian AppRoximation for Inferring Selection", https://academic.oup.com/mbe/article/30/5/1196/998247 <br>
3. "Detecting Individual Sites Subject to Episodic Diversifying Selection", https://journals.plos.org/plosgenetics/article?id=10.1371/journal.pgen.1002764 <br>

# Resources
1. https://www.datamonkey.org/ <br>
2. http://hyphy.org/<br>
