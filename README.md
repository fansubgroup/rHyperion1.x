# rHyperion1.x

This is a Ruby version Hyperion1.x(which is a tool bases on Python)

Supports the translation work under the command line

### There are some new features in this version

#### [1] First, rHyperion1.x is based on Ruby

rHypersion 1.x was written by Ruby 2.3.0 and some third-party gems provided by the [RubyGems.org](https://rubygems.org/),which is 

friendly to some enthusiasts of Ruby.

#### [2] Second, rHyperion1.x has three http get engines for you to choose

There are:

1. Ruby open-uri : smallest , but slowest
2. Go net/http : Go-lang's net/http no only faster than Ruby open-uri but also has a stabler Garbage Collection mechanism than Nim. But the volume of the lib generated by Go is nearly 10 times larger than Nim's. 
3. Nim httpclient : fast http speed and small volume , but it is not stable enough to deal with a very large .srt file.

**(PS:)**
**(Because the .so library of the Go-lang took up 7+ M space,so I compressed it as a .rar file.)**
**(Therefore ,if you want to use the http get engine of Golang,please extract it from the .rar file at first. )**

### How to use these tool?

* Download the entrie folder to your local directory

* Install the `Ruby 2.3.0 or up`

* Install the ffi gem of Ruby => `gems install ffi`

**(if you want to modify the code , you may also need the development environment of Golang an Nim-lang)**

### * In the program directory, there is a configure file name `appkey`, Input you `appid` in the first line, and the `sercetKey` in second line 

* Use the `cmd` (Windows) or `shell` (Linux) switch to the place where you put the program

* Input the command in `cmd` (Windows) or `shell` (Linux) like this:
```
$ ruby ./trans.rb YOU_SOURCE_LANGUAGE YOU_TARGET_LANGUAGE

```
#### This coeerspondence table is here

<table>
<tr>
      <td>Symbol</td>
      <td>Significance</td>
   </tr>
   <tr>
      <td>auto </td>
      <td>automatic detection</td>
   </tr>
   <tr>
      <td>zh </td>
      <td>Chinese</td>
   </tr>
   <tr>
      <td>en </td>
      <td>English</td>
   </tr>
   <tr>
      <td>yue </td>
      <td>Cantonese</td>
   </tr>
   <tr>
      <td>wyw </td>
      <td>Classical Chinese</td>
   </tr>
   <tr>
      <td>jp </td>
      <td>Japanese</td>
   </tr>
   <tr>
      <td>kor </td>
      <td>Korean</td>
   </tr>
   <tr>
      <td>fra </td>
      <td>French</td>
   </tr>
   <tr>
      <td>spa </td>
      <td>Spain</td>
   </tr>
   <tr>
      <td>th </td>
      <td>Thai</td>
   </tr>
   <tr>
      <td>ara </td>
      <td>Arabic</td>
   </tr>
   <tr>
      <td>ru </td>
      <td>Russian</td>
   </tr>
   <tr>
      <td>pt </td>
      <td>Portuguese</td>
   </tr>
   <tr>
      <td>de </td>
      <td>German</td>
   </tr>
   <tr>
      <td>it </td>
      <td>Italian</td>
   </tr>
   <tr>
      <td>el </td>
      <td>Greek</td>
   </tr>
   <tr>
      <td>nl </td>
      <td>Dutch</td>
   </tr>
   <tr>
      <td>pl </td>
      <td>Polish</td>
   </tr>
   <tr>
      <td>bul </td>
      <td>Bulgarian</td>
   </tr>
   <tr>
      <td>est </td>
      <td>Estonia Language</td>
   </tr>
   <tr>
      <td>dan </td>
      <td>Danish</td>
   </tr>
   <tr>
      <td>fin </td>
      <td>Finnish</td>
   </tr>
   <tr>
      <td>cs </td>
      <td>Czech</td>
   </tr>
   <tr>
      <td>rom </td>
      <td>Romanian</td>
   </tr>
   <tr>
      <td>slo </td>
      <td>Slovenia Language</td>
   </tr>
   <tr>
      <td>swe </td>
      <td>Swedish</td>
   </tr>
   <tr>
      <td>hu </td>
      <td>Hugarian language</td>
   </tr>
   <tr>
      <td>cht </td>
      <td>Traditional Chinese</td>
   </tr>
</table>

