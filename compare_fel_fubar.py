#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Feb 19 21:02:09 2020

@author: alexander g. lucaci

Given FEL and FUBAR look which sites are called for + or - selection.



"""
# =============================================================================
# Imports
# =============================================================================
import os
import json

# =============================================================================
# Declares
# =============================================================================
FEL_DIR = "/Users/alex/Documents/stats_final_proj/OUTPUT_JSONS/FEL" # FEL jsons
FUBAR_DIR = "/Users/alex/Documents/stats_final_proj/OUTPUT_JSONS/0VB" #Fubar jsons


pvalue = 0.1
posterior_prob = 0.9


#Give a pvalue or posterior prob.
#{Filename} = [[Sites with + selection], [Sites with - Selection]]


FEL_FUBAR = {}
# =============================================================================
#  funcs
# =============================================================================

def get_sites_FEL(filename):
    global FEL_FUBAR, pvalue
    with open(filename, "r") as fh:
        json_data = json.load(fh)
        fh.close()
        
    for n, site in enumerate(json_data["MLE"]["content"]["0"]):
        # alpha, beta, alpha=beta, LRT, pvalue, total branch length
        if float(site[4]) <= pvalue: 
            alpha = float(site[0])
            beta = float(site[1])
            
            if alpha > 0.0:
                omega = beta / alpha
            elif alpha == 0.0 and beta == 0.0:
                omega = "NaN"
            elif alpha == 0.0 and beta > 0.0:
                omega = 99999999999999
            else:
                omega = 99999999999999
    
            #print(n + 1, site)
            #print(n+1, omega , site[4])
            
            #Register this in FEL_FUBAR
            
            if omega == "NaN": continue
        
            if omega > 1.0:
                FEL_FUBAR[filename.split("/")[-1]][0] += [n+1]
            if omega < 1.0:
                FEL_FUBAR[filename.split("/")[-1]][1] += [n+1]
#end method


def get_sites_FUBAR(filename):
    global FEL_FUBAR, posterior_prob
    with open(filename, "r") as fh:
        json_data = json.load(fh)
        fh.close()
        
    for n, site in enumerate(json_data["MLE"]["content"]["0"]):
        # alpha, beta, beta-alpha, prob[a>b], prob[a<b], bayesfactor[a<b]
        #alpha = float(site[0])
        #beta = float(site[1])
        
        if float(site[3]) >= posterior_prob: #negative selection
            
            FEL_FUBAR[filename.split("/")[-1]][1] += [n+1]
        elif float(site[4]) >= posterior_prob: #positive selection

             FEL_FUBAR[filename.split("/")[-1]][0] += [n+1]
        else:
            pass
#end method

# =============================================================================
# 
# =============================================================================
print("# Processing FEL")
#FEL
for root, dirs, files in os.walk(FEL_DIR):
    for n, each_file in enumerate(files):
        name, ext = os.path.splitext(each_file)  
        if ext in [".json"]:
            process_file = os.path.join(FEL_DIR, each_file)
            #print(each_file, process_file)
            print(n, "Processing:", each_file)
            FEL_FUBAR[each_file] = [[], []]
            if ".FEL.json" in each_file:
                get_sites_FEL(process_file)

print("\n# Processing FEL")
#FUBAR
for root, dirs, files in os.walk(FUBAR_DIR):
    for n, each_file in enumerate(files):
        name, ext = os.path.splitext(each_file)  
        if ext in [".json"]:
            process_file = os.path.join(FUBAR_DIR, each_file)
            #print(each_file, process_file)
            print(n, "Processing:", each_file)
            FEL_FUBAR[each_file] = [[], []]
            if ".FUBAR.json" in each_file:
                get_sites_FUBAR(process_file)
       
            
            
print("\n# Report")       
          
for item in FEL_FUBAR:
    if 0.0 in FEL_FUBAR[item][0]:
        print("shit")
    if 0.0 in FEL_FUBAR[item][1]:
        print("shitty")
        
    print(item, len(FEL_FUBAR[item][0]), len(FEL_FUBAR[item][1]))
print()  
    
for item in FEL_FUBAR:
    if ".FEL.json" in item:
        #print(item, len(FEL_FUBAR[item][0]), len(FEL_FUBAR[item][1]))
        FEL_FILE = item
        FUBAR_FILE = item.replace(".FEL.json", ".FUBAR.json")
        
        FEL_POSITIVE_SELECTION = FEL_FUBAR[FEL_FILE][0]
        FEL_NEGATIVE_SELECTION = FEL_FUBAR[FEL_FILE][1]
        FUBAR_POSITIVE_SELECTION = FEL_FUBAR[FUBAR_FILE][0]
        FUBAR_NEGATIVE_SELECTION = FEL_FUBAR[FUBAR_FILE][1]
        
        print("\n# Round 1.", FEL_FILE, FUBAR_FILE)
        print("Checking if FEL positive selection site(s) occur in FUBAR negatively selected sites")
        for site in FEL_POSITIVE_SELECTION:
            if site in FUBAR_NEGATIVE_SELECTION:
                print("\t### CONFLICT", FEL_FILE, FUBAR_FILE, site)
        
        print("Checking if FEL negatively selected site(s) occur in FUBAR positively selected sites")
        for site in FEL_NEGATIVE_SELECTION:
            if site in FUBAR_POSITIVE_SELECTION:
                print("\t### CONFLICT", FEL_FILE, FUBAR_FILE, site)
        
        
        print("\n# Round 2.", FUBAR_FILE)
        print("Checking if FUBAR positive selection site(s) occur in FEL negatively selected sites")
        for site in FUBAR_POSITIVE_SELECTION:
            if site in FEL_NEGATIVE_SELECTION:
                print("\t### CONFLICT", FEL_FILE, FUBAR_FILE, site)
                      
        print("Checking if FUBAR negatively selected site(s) occur in FEL positively selected sites")
        for site in FUBAR_NEGATIVE_SELECTION:
            if site in FEL_POSITIVE_SELECTION:
                print("\t### CONFLICT", FEL_FILE, FUBAR_FILE, site)
        
        
        
    
#The idea is, are there any sites in FEL which were called positve, that are called negative in FUBAR
#vice versa, and for negatives
        
        
        
    

# =============================================================================
# End file
# =============================================================================


