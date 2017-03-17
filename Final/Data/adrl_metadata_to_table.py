from bs4 import BeautifulSoup
import urllib
import re

input_file = open('C:/Users/abruggma/Documents/_PhD/Santa_Barbara/ADRL/adrl_websites_pid.txt', 'r')
input_lines = input_file.readlines()
input_file.close()
output_file = open('C:/Users/abruggma/Documents/_PhD/Santa_Barbara/ADRL/metadata_html.txt', 'w')


for line in input_lines:
    address_list = line.split(' ')
    #print address

for address in address_list:    
    r = urllib.urlopen(address)
    soup = BeautifulSoup(r)
    soup.prettify()
    #print soup
    output_file.write(str(soup) + '\n')
output_file.close()

pid_file = open('C:/Users/abruggma/Documents/_PhD/Santa_Barbara/ADRL/metadata_html.txt', 'r')
pid_file_addresses = open('C:/Users/abruggma/Documents/_PhD/Santa_Barbara/ADRL/pids.txt', 'w')
input_pid_file = pid_file.read()

print "All search results (incl. pids) successfully retrieved"

#print input_pid_file
substitute_tags = re.sub(r'\{\"docs\"\:\[\{\"pid\"\:\"', '', input_pid_file)
substitute_tags = re.sub(r'\",\"title.*?\{\"pid\"\:\"', '\n', substitute_tags)
substitute_tags = re.sub(r'\",\"title.*?\"\}\]\}', '', substitute_tags)
substitute_tags = re.sub(r'\n', '.ttl\nhttp://alexandria.ucsb.edu/lib/ark:/48907/', substitute_tags, flags=re.DOTALL)
substitute_tags = re.sub(r'f3bz65v3', 'http://alexandria.ucsb.edu/lib/ark:/48907/f3bz65v3', substitute_tags, flags=re.DOTALL)
substitute_tags = re.sub(r'f3348hkz.ttl\nhttp://alexandria.ucsb.edu/lib/ark:/48907/', 'f3348hkz.ttl', substitute_tags, flags=re.DOTALL)
substitute_tags = re.sub(r'\n', ' ', substitute_tags, flags=re.DOTALL)
#print substitute_tags
pid_file_addresses.write(str(substitute_tags))

pid_file.close()
pid_file_addresses.close()

print "All pids converted into HTML"

iterate_pid_file = open('C:/Users/abruggma/Documents/_PhD/Santa_Barbara/ADRL/pids.txt', 'r')
pids = iterate_pid_file.readlines()
iterate_pid_file.close()
pid_metadata = open('C:/Users/abruggma/Documents/_PhD/Santa_Barbara/ADRL/pid_metadata.txt', 'w')
n = 0

for line in pids:
    pid_list = line.split(' ')
    #print pid_list
    
for pid in pid_list:    
    p = urllib.urlopen(pid)
    soup = BeautifulSoup(p)
    soup.prettify()
    #print soup
    pid_metadata.write(str(soup) + '\n')
    n += 1
    print "Document nr " + str(n) + " successfully retrieved"

pid_metadata.close()

print "Metadata successfully retrieved"


metadata_file = open('C:/Users/abruggma/Documents/_PhD/Santa_Barbara/ADRL/pid_metadata.txt', 'r')
metadata_reading = metadata_file.read()
metadata_file.close()
metadata_file_sorted = open('C:/Users/abruggma/Documents/_PhD/Santa_Barbara/ADRL/metadata.txt', 'w')
m = 0

substitute_metadata = re.sub(r'\,\n', ' ', metadata_reading, flags=re.DOTALL)
metadata_file_sorted.write(substitute_metadata)

metadata_file_sorted.close()

metadata_table = open('C:/Users/abruggma/Documents/_PhD/Santa_Barbara/ADRL/metadata_table.txt', 'w')
metadata_file_input = open('C:/Users/abruggma/Documents/_PhD/Santa_Barbara/ADRL/metadata.txt', 'r')
metadata_lines = metadata_file_input.readlines()
#print metadata_lines

metadata_table.write('title' + "\t" + 'year' + "\t" + 'author' + "\t" + 'degree grantor' + "\t" + 'degree supervisor' + "\t" + 'description' + "\t" + 'language' + "\n")

for line in metadata_lines:
    if 'title=""' in line:
        #print line
        #m += 1
        #print m
        substitute_title = re.sub(r'   \<http\: dc\=\"\" purl.org\=\"\" terms\=\"\" title\=\"\"> ', '', line)
        substitute_title = re.sub(r'\"\;\n', '"', substitute_title)
        print substitute_title + "\t"
        metadata_table.write(substitute_title + "\t")
    elif 'dissertationyear' in line:
        substitute_year = re.sub(r'   \<http\: bibframe\.org=\"\" dissertationyear=\"\" vocab\=\"\"> ', '', line)
        substitute_year = re.sub(r'\"\;\n', '"', substitute_year)
        print substitute_year + "\t"
        metadata_table.write(substitute_year + "\t")
    elif 'aut="" ' in line:
        substitute_author = re.sub(r'   \<http\: aut\=\"\" id\.loc\.gov\=\"\" relators\=\"\" vocabulary\=\"\"> ', '', line)
        substitute_author = re.sub(r'\"\;\n', '"', substitute_author)
        #m += 1
        print substitute_author + "\t"
        #print m
        metadata_table.write(substitute_author + "\t")
    elif 'dgg="" id.loc.gov=""' in line:
        substitute_dgg = re.sub(r'   \<http\: dgg\=\"\" id\.loc\.gov\=\"\" relators\=\"\" vocabulary\=\"\"> ', '', line)
        substitute_dgg = re.sub(r'\"\;\n', '"', substitute_dgg)
        #m += 1
        print substitute_dgg + "\t"
        #print m
        metadata_table.write(substitute_dgg + "\t")
    elif 'dgs=""' in line:
        substitute_dgs = re.sub(r'   \<http\: dgs=\"\" id\.loc\.gov\=\"\" relators\=\"\" vocabulary\=\"\"> ', '', line)
        substitute_dgs = re.sub(r'\"\;\n', '"', substitute_dgs)
        #m += 1
        print substitute_dgs + "\t"
        #print m
        metadata_table.write(substitute_dgs + "\t")
    elif 'description=""' in line:
        substitute_description = re.sub(r'   \<http\: dc\=\"\" description\=\"\" purl\.org\=\"\" terms\=\"\"\> ', '', line)
        substitute_description = re.sub(r'\"\;\n', '"', substitute_description)
        #m += 1
        print substitute_description + "\t"
        #print m
        metadata_table.write(substitute_description + "\t")
    elif 'dc="" language' in line:        
        substitute_language = re.sub(r'   \<http\: dc\=\"\" language\=\"\" purl\.org=\"\" terms\=\"\"> ', '', line)
        substitute_language = re.sub(r'\"\;\n', '"', substitute_language)
        m += 1
        print substitute_language + "\t"
        print m
        metadata_table.write(substitute_language + "\n")
        
    
    
#metadata_lines = substitute_metadata.readlines()


#print substitute_metadata

print "Script finished successfully"

#r = urllib.urlopen('http://www.alexandria.ucsb.edu/catalog.json?f%5Bform_of_work_label_sim%5D%5B%5D=Dissertations%2C+Academic&page=2&per_page=100&q=%2A&search_field=all_fields')
#soup = BeautifulSoup(r)
#print soup
#print type(soup)
#print soup.prettify()

