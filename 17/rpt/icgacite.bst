% This is ICGACITE.BST
% It is a copy of UMCITE.BST, intended only for use with the ICGA
% style.
%
%  Turn 'van' into 'Van' in citations
%  Sorts on family name, not on 'van'
%  added long auhtor list for first reference
%
% It is based on RLTHESIS.BST, which header is shown below
% 15 March 1998
% Changes: in INPROCEEDINGS the order is now publisher, address, which is the same as in
% INCOLLECTION. 'chapter' is changed to 'Chapter'.
% It is based on ALPHA.BST, which header is shown below
% BibTeX standard bibliography style `alpha'
    % version 0.99a for BibTeX versions 0.99a or later, LaTeX version 2.09.
    % Copyright (C) 1985, all rights reserved.
    % Copying of this file is authorized only if either
    % (1) you make absolutely no changes to your copy, including name, or
    % (2) if you do make changes, you name it something other than
    % btxbst.doc, plain.bst, unsrt.bst, alpha.bst, and abbrv.bst.
    % This restriction helps ensure that all standard styles are identical.
    % The file btxbst.doc has the documentation for this style.
% Change log for RLTHESIS.BST
% 20 november 1993
%  Changes by Harm Bakker, based on the old rlthesis.bst, which was
%  based on alpha.bst for BibTeX versions 0.98
%  The old version would cause many errors ("" is a string literal, not a
%  function, etc.). These were probably caused by the different ordering of operands
%  of the basic primitive := in BibTeX (they have been swapped in the
%  new version).
%  All types of entries in the bibliography have been updated.
%  In addition, creating extra labels in case of equal labels seems to
%  work satisfactorily.
%  etalchar has been redefined to be {\em et al.}
%  Amount of time required: approx. 7 hours
%

ENTRY
  { address
    author
    booktitle
    chapter
    edition
    editor
    howpublished
    isbn
    institution
    issn
    journal
    key
    month
    note
    number
    organization
    pages
    publisher
    school
    series
    title
    type
    url
    volume
    year
  }
  {}
  { label extra.label sort.label year.label full.label}

INTEGERS { output.state before.all mid.sentence after.sentence after.block }

FUNCTION {init.state.consts}
{ #0 'before.all :=
  #1 'mid.sentence :=
  #2 'after.sentence :=
  #3 'after.block :=
}

STRINGS { s t }

FUNCTION {output.nonnull}
{ 's :=
  output.state mid.sentence =
    { ", " * write$ }
    { output.state after.block =
    { add.period$ write$
      newline$
      "\newblock " write$
    }
    { output.state before.all =
        'write$
        { add.period$ " " * write$ }
      if$
    }
      if$
      mid.sentence 'output.state :=
    }
  if$
  s
}

FUNCTION {output}
{ duplicate$ empty$
    'pop$
    'output.nonnull
  if$
}

FUNCTION {output.check}
{ 't :=
  duplicate$ empty$
    { pop$ "empty " t * " in " * cite$ * warning$ }
    'output.nonnull
  if$
}

FUNCTION {output.bibitem}
{ newline$
  "\harmsbibitem{" write$
  full.label write$
  "}{" write$
  label write$
  "}{" write$
  year.label write$
  "}{" write$
  cite$ write$
  "}{%" write$
  newline$
  ""
  before.all 'output.state :=
}

FUNCTION {fin.entry}
{ add.period$
  write$
"}" write$
  newline$
}

FUNCTION {new.block}
{ output.state before.all =
    'skip$
    { after.block 'output.state := }
  if$
}

FUNCTION {new.sentence}
{ output.state after.block =
    'skip$
    { output.state before.all =
    'skip$
    { after.sentence 'output.state := }
      if$
    }
  if$
}

FUNCTION {not}
{   { #0 }
    { #1 }
  if$
}

FUNCTION {and}
{   'skip$
    { pop$ #0 }
  if$
}

FUNCTION {or}
{   { pop$ #1 }
    'skip$
  if$
}

FUNCTION {new.block.checka}
{ empty$
    'skip$
    'new.block
  if$
}

FUNCTION {new.block.checkb}
{ empty$
  swap$ empty$
  and
    'skip$
    'new.block
  if$
}

FUNCTION {new.sentence.checka}
{ empty$
    'skip$
    'new.sentence
  if$
}

FUNCTION {new.sentence.checkb}
{ empty$
  swap$ empty$
  and
    'skip$
    'new.sentence
  if$
}

FUNCTION {field.or.null}
{ duplicate$ empty$
    { pop$ "" }
    'skip$
  if$
}

FUNCTION {emphasize}
{ duplicate$ empty$
    { pop$ "" }
    { "{\sl " swap$ * "}" * }
  if$
}

INTEGERS { nameptr namesleft numnames }



FUNCTION {format.names.initials.first}
{ 's :=
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { s nameptr "{f.}{ vv}{ ll}{, jj}" format.name$ 't :=
      nameptr #1 >
    { namesleft #1 >
        { ", " * t * }
        { numnames #2 >
        { "," * }
        'skip$
          if$
          t "others" =
        { " et~al." * }
        { " and " * t * }
          if$
        }
      if$
    }
    't
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
}

FUNCTION {format.names}
{ 's :=
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { s nameptr "{ll}{, f.}{ vv}{, jj}" format.name$ 't :=
%    { s nameptr "{vv }{ll}{, f.}{, jj}" format.name$ 't :=
      nameptr #1 >
    { namesleft #1 >
        { ", " * t * }
        { numnames #2 >
        { "," * }
        'skip$
          if$
          t "others" =
        { " et~al." * }
        { " and " * t * }
          if$
        }
      if$
    }
    't
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
}

FUNCTION {format.authors}
{ author empty$
    { "" }
    { author format.names }
  if$
}

FUNCTION {format.editors}
{ editor empty$
    { "" }
    { editor num.names$ #1 >
    {"eds. " editor format.names.initials.first * }
    { "ed. " editor format.names.initials.first * }
      if$
    }
  if$
}

FUNCTION {format.book.editors}
{ editor empty$
    { "" }
    { editor num.names$ #1 >
    { editor format.names " (eds.)" * }
    { editor format.names " (ed.)" * }
      if$
    }
  if$
}


FUNCTION {format.title}
{ title empty$
    { "" }
    { title }
  if$
}

%FUNCTION {format.title}
%{ title empty$
%   { "" }
%    { title "t" change.case$ }
%  if$
%}

FUNCTION {n.dashify}
{ 't :=
  ""
    { t empty$ not }
    { t #1 #1 substring$ "-" =
    { t #1 #2 substring$ "--" = not
        { "--" *
          t #2 global.max$ substring$ 't :=
        }
        {   { t #1 #1 substring$ "-" = }
        { "-" *
          t #2 global.max$ substring$ 't :=
        }
          while$
        }
      if$
    }
    { t #1 #1 substring$ *
      t #2 global.max$ substring$ 't :=
    }
      if$
    }
  while$
}

% Changed HB
FUNCTION {format.date}
{ year empty$
    { "there's no year year in " cite$ * warning$
      ""
    }
    { " (" year.label * ")" * }
  if$
}

FUNCTION {format.btitle}
{ title emphasize
}

FUNCTION {tie.or.space.connect}
{ duplicate$ text.length$ #3 <
    { "~" }
    { " " }
  if$
  swap$ * *
}

FUNCTION {either.or.check}
{ empty$
    'pop$
    { "can't use both " swap$ * " fields in " * cite$ * warning$ }
  if$
}

FUNCTION {format.bvolume}
{ volume empty$
    { "" }
    { "Vol." volume tie.or.space.connect
      series empty$
    'skip$
    { " of " * series emphasize * }
      if$
      "volume and number" number either.or.check
    }
  if$
}

FUNCTION {format.number.series}
{ volume empty$
    { number empty$
    { series field.or.null }
    { output.state mid.sentence =
        { "number" }
        { "Number" }
      if$
      number tie.or.space.connect
      series empty$
        { "there's a number but no series in " cite$ * warning$ }
        { " in " * series * }
      if$
    }
      if$
    }
    { "" }
  if$
}

FUNCTION {format.edition}
{ edition empty$
    { "" }
    { output.state mid.sentence =
    { edition "l" change.case$ " edition" * }
    { edition "t" change.case$ " edition" * }
      if$
    }
  if$
}

FUNCTION {format.url}
{ url empty$
    { "" }
    { " \url{" url * "}" * }
  if$
}


FUNCTION {format.isbn}
{ isbn empty$
    { "" }
    { " ISBN " isbn n.dashify * }
  if$
}

FUNCTION {format.issn}
{ issn empty$
    { "" }
    { "ISSN " issn n.dashify * }
  if$
}

INTEGERS { multiresult }

FUNCTION {multi.pagnum.check}
{ 't :=
  #0 'multiresult :=
    { multiresult not
      t empty$ not
      and
    }
    { t #1 #1 substring$
      duplicate$ "-" =
      swap$ duplicate$ "," =
      swap$ "+" =
      or or
    { #1 'multiresult := }
    { t #2 global.max$ substring$ 't := }
      if$
    }
  while$
  multiresult
}

FUNCTION {format.pages}
{ pages empty$
    { "" }
    { pages multi.pagnum.check
    { "pp." pages n.dashify tie.or.space.connect }
    { "p." pages tie.or.space.connect }
      if$
    }
  if$
}

FUNCTION {format.number}
{ number empty$
    { "" }
    { number multi.pagnum.check
    { "Nos." number n.dashify tie.or.space.connect }
    { "No." number tie.or.space.connect }
      if$
    }
  if$
}

FUNCTION {format.vol.num.pages}
{ volume empty$
    { "" "there's no volume number in " cite$ * warning$ }
    { "Vol.~" volume * }
  if$
  number empty$
    'skip$
    { duplicate$ empty$
    { pop$ format.number }
    { ", " * format.number * }
      if$
    }
  if$
  pages empty$
    'skip$
    { duplicate$ empty$
    { pop$ format.pages }
    { ", " * format.pages * }
      if$
    }
  if$
}

FUNCTION {format.chapter.pages}
{ chapter empty$
    'format.pages
    { type empty$
    { "Chapter" }
    { type "l" change.case$ }
      if$
      chapter tie.or.space.connect
      pages empty$
    'skip$
    { ", " * format.pages * }
      if$
    }
  if$
}

FUNCTION {format.in.ed.booktitle}
{ booktitle empty$
    { "" }
    { editor empty$
    { booktitle emphasize }
    { booktitle emphasize "~(" * format.editors * ")" * }
      if$
    }
  if$
}

%FUNCTION {format.in.ed.booktitle}
%{ booktitle empty$
%    { "" }
%    { editor empty$
%   { "In " booktitle emphasize * }
%   { "In " format.editors * ", " * booktitle emphasize * %}
%      if$
%    }
%  if$
%}

FUNCTION {empty.misc.check}
{ author empty$ title empty$ howpublished empty$
  month empty$ year empty$ note empty$
  and and and and and
  key empty$ not and
    { "all relevant fields are empty in " cite$ * warning$ }
    'skip$
  if$
}

FUNCTION {format.thesis.type}
{ type empty$
    'skip$
    { pop$
      type "t" change.case$
    }
  if$
}

FUNCTION {format.tr.number}
{ type empty$
    { "Technical Report" }
    'type
  if$
  number empty$
    { "t" change.case$ }
    { number tie.or.space.connect }
  if$
}

FUNCTION {format.article.crossref}
{ key empty$
    { journal empty$
    { "need key or journal for " cite$ * " to crossref " * crossref *
      warning$
      ""
    }
    { "In {\em " journal * "\/}" * }
      if$
    }
    { "In " key * }
  if$
  " \cited{" * crossref * "}" *
}

FUNCTION {format.crossref.editor}
{ editor #1 "{vv~}{ll}" format.name$
  editor num.names$ duplicate$
  #2 >
    { pop$ " et~al." * }
    { #2 <
    'skip$
    { editor #2 "{ff }{vv }{ll}{ jj}" format.name$ "others" =
        { " et~al." * }
        { " and " * editor #2 "{vv~}{ll}" format.name$ * }
      if$
    }
      if$
    }
  if$
}

FUNCTION {format.book.crossref}
{ volume empty$
    { "empty volume in " cite$ * "'s crossref of " * crossref * warning$
      "In "
    }
    { "Volume" volume tie.or.space.connect
      " of " *
    }
  if$
  editor empty$
  editor field.or.null author field.or.null =
  or
    { key empty$
    { series empty$
        { "need editor, key, or series for " cite$ * " to crossref " *
          crossref * warning$
          "" *
        }
        { "{\em " * series * "\/}" * }
      if$
    }
    { key * }
      if$
    }
    { format.crossref.editor * }
  if$
  " \cited{" * crossref * "}" *
}

FUNCTION {format.incoll.inproc.crossref}
{ editor empty$
  editor field.or.null author field.or.null =
  or
    { key empty$
    { booktitle empty$
        { "need editor, key, or booktitle for " cite$ * " to crossref " *
          crossref * warning$
          ""
        }
        { "In {\em " booktitle * "\/}" * }
      if$
    }
    { "In " key * }
      if$
    }
    { "In " format.crossref.editor * }
  if$
  " \cited{" * crossref * "}" *
}

% Changed HB, compare with alpha.bst original for changes
FUNCTION {article}
{ output.bibitem
  format.authors "author" output.check
  before.all 'output.state :=
  %" " write$
  format.date "year" output.check
  new.block
  format.title "title" output.check
  new.block
  crossref missing$
    { journal emphasize "journal" output.check
      format.vol.num.pages output
      %format.date "year" output.check
    }
    { format.article.crossref output.nonnull
      format.pages output
    }
  if$
  new.block
  format.isbn output
  format.issn output
  new.sentence
  format.url output
  new.block
  note output
  fin.entry
}

FUNCTION {book}
{ output.bibitem
  author empty$
    { format.book.editors "author and editor" output.check }
    { format.authors output.nonnull
      crossref missing$
    { "author and editor" editor either.or.check }
    'skip$
      if$
    }
  if$
  before.all 'output.state :=
  format.date "year" output.check
  new.block
  format.btitle "title" output.check
  crossref missing$
    { format.bvolume output
      new.block
      format.number.series output
      new.sentence
      publisher "publisher" output.check
      address output
    }
    { new.block
      format.book.crossref output.nonnull
    }
  if$
  format.edition output
  %format.date "year" output.check
  new.block
  format.isbn output
  format.issn output
  new.sentence
  format.url output
  new.block
  note output
  fin.entry
}

FUNCTION {booklet}
{ output.bibitem
  format.authors output
  before.all 'output.state :=
  format.date "year" output.check
  new.block
  format.title "title" output.check
  howpublished address new.block.checkb
  howpublished output
  address output
  %format.date output
  new.block
  format.isbn output
  format.issn output
  new.sentence
  format.url output
  new.block
  note output
  fin.entry
}

FUNCTION {inbook}
{ output.bibitem
  author empty$
    { format.book.editors "author and editor" output.check }
    { format.authors output.nonnull
      crossref missing$
    { "author and editor" editor either.or.check }
    'skip$
      if$
    }
  if$
  before.all 'output.state :=
  format.date "year" output.check
  new.block
  format.btitle "title" output.check
  crossref missing$
    { format.bvolume output
      format.chapter.pages "chapter and pages" output.check
      new.block
      format.number.series output
      new.sentence
      publisher "publisher" output.check
      address output
    }
    { format.chapter.pages "chapter and pages" output.check
      new.block
      format.book.crossref output.nonnull
    }
  if$
  format.edition output
  %format.date "year" output.check
  new.block
  format.isbn output
  format.issn output
  new.sentence
  format.url output
  new.block
  note output
  fin.entry
}

FUNCTION {incollection}
{ output.bibitem
  format.authors "author" output.check
  before.all 'output.state :=
  format.date "year" output.check
  new.block
  format.title "title" output.check
  new.block
  crossref missing$
    { format.in.ed.booktitle "booktitle" output.check
      format.bvolume output
      format.number.series output
      format.chapter.pages output
      new.sentence
      publisher "publisher" output.check
      address output
      format.edition output
      %format.date "year" output.check
    }
    { format.incoll.inproc.crossref output.nonnull
      format.chapter.pages output
    }
  if$
  new.block
  format.isbn output
  format.issn output
  new.sentence
  format.url output
  new.block
  note output
  fin.entry
}

% Changed FW
FUNCTION {inproceedings}
{ output.bibitem
  format.authors "author" output.check
  before.all 'output.state :=
  format.date "year" output.check
  new.block
  format.title "title" output.check
  new.block
  crossref missing$
    { format.in.ed.booktitle "booktitle" output.check
      format.bvolume output
      format.number.series output
      format.pages output
      organization output
      publisher output
      address empty$
    { %organization publisher new.sentence.checkb
      %organization output
      %publisher output
      %format.date "year" output.check
    }
    { address output.nonnull
      %format.date "year" output.check
      new.sentence
      %organization output
      %publisher output
    }
      if$
    }
    { format.incoll.inproc.crossref output.nonnull
      format.pages output
    }
  if$
  new.block
  format.isbn output
  format.issn output
  new.sentence
  format.url output
  new.block
  note output
  fin.entry
}

FUNCTION {conference} { inproceedings }

FUNCTION {manual}
{ output.bibitem
  author empty$
    { organization empty$
    'skip$
    { organization output.nonnull
      address output
    }
      if$
    }
    { format.authors output.nonnull }
  if$
  before.all 'output.state :=
  format.date "year" output.check
  new.block
  format.btitle "title" output.check
  author empty$
    { organization empty$
    { address new.block.checka
      address output
    }
    'skip$
      if$
    }
    { organization address new.block.checkb
      organization output
      address output
    }
  if$
  format.edition output
  %format.date output
  new.block
  format.isbn output
  format.issn output
  new.sentence
  format.url output
  new.block
  note output
  fin.entry
}

FUNCTION {mastersthesis}
{ output.bibitem
  format.authors "author" output.check
  before.all 'output.state :=
  format.date "year" output.check
  new.block
  format.title "title" output.check
  new.block
  "M.Sc. thesis" format.thesis.type output.nonnull
  school "school" output.check
  address output
  %format.date "year" output.check
  new.sentence
  format.url output
  new.block
  note output
  fin.entry
}

FUNCTION {misc}
{ output.bibitem
  format.authors output
  before.all 'output.state :=
  format.date "year" output.check
  title howpublished new.block.checkb
  format.title output
  howpublished new.block.checka
  howpublished output
  %format.date output
  new.block
  format.isbn output
  format.issn output
  new.sentence
  format.url output
  new.block
  note output
  fin.entry
  empty.misc.check
}

FUNCTION {webpage}
{ output.bibitem
  format.authors output
  before.all 'output.state :=
  format.date "year" output.check
  format.title "title" output.check
  new.sentence
  format.url "url" output.check
  new.block
  note output
  fin.entry
}

FUNCTION {phdthesis}
{ output.bibitem
  format.authors "author" output.check
  before.all 'output.state :=
  format.date "year" output.check
  new.block
  format.btitle "title" output.check
  new.block
  "Ph.D. thesis" format.thesis.type output.nonnull
  school "school" output.check
  address output
  %format.date "year" output.check
  new.block
  format.isbn output
  format.issn output
  new.sentence
  format.url output
  new.block
  note output
  fin.entry
}

FUNCTION {proceedings}
{ output.bibitem
  editor empty$
    { organization output }
    { format.book.editors output.nonnull }
  if$
  before.all 'output.state :=
  format.date "year" output.check
  new.block
  format.btitle "title" output.check
  format.bvolume output
  format.number.series output
  address empty$
    { editor empty$
    { publisher new.sentence.checka }
    { organization publisher new.sentence.checkb
      organization output
    }
      if$
      publisher output
      %format.date "year" output.check
    }
    { address output.nonnull
      %format.date "year" output.check
      new.sentence
      editor empty$
    'skip$
    { organization output }
      if$
      publisher output
    }
  if$
  new.block
  format.isbn output
  format.issn output
  new.sentence
  format.url output
  new.block
  note output
  fin.entry
}

FUNCTION {techreport}
{ output.bibitem
  format.authors "author" output.check
  before.all 'output.state :=
  format.date "year" output.check
  new.block
  format.title "title" output.check
  new.block
  format.tr.number output.nonnull
  institution "institution" output.check
  address output
  %format.date "year" output.check
  new.block
  format.isbn output
  format.issn output
  new.sentence
  format.url output
  new.block
  note output
  fin.entry
}

FUNCTION {unpublished}
{ output.bibitem
  format.authors "author" output.check
  before.all 'output.state :=
  format.date "year" output.check
  new.block
  format.title "title" output.check
  new.sentence
  format.url output
  new.block
  note "note" output.check
  %format.date output
  fin.entry
}

FUNCTION {default.type} { misc }

MACRO {jan} {"January"}

MACRO {feb} {"February"}

MACRO {mar} {"March"}

MACRO {apr} {"April"}

MACRO {may} {"May"}

MACRO {jun} {"June"}

MACRO {jul} {"July"}

MACRO {aug} {"August"}

MACRO {sep} {"September"}

MACRO {oct} {"October"}

MACRO {nov} {"November"}

MACRO {dec} {"December"}

MACRO {acmcs} {"ACM Computing Surveys"}

MACRO {acta} {"Acta Informatica"}

MACRO {cacm} {"Communications of the ACM"}

MACRO {ibmjrd} {"IBM Journal of Research and Development"}

MACRO {ibmsj} {"IBM Systems Journal"}

MACRO {ieeese} {"IEEE Transactions on Software Engineering"}

MACRO {ieeetc} {"IEEE Transactions on Computers"}

MACRO {ieeetcad}
 {"IEEE Transactions on Computer-Aided Design of Integrated Circuits"}

MACRO {ipl} {"Information Processing Letters"}

MACRO {jacm} {"Journal of the ACM"}

MACRO {jcss} {"Journal of Computer and System Sciences"}

MACRO {scp} {"Science of Computer Programming"}

MACRO {sicomp} {"SIAM Journal on Computing"}

MACRO {tocs} {"ACM Transactions on Computer Systems"}

MACRO {tods} {"ACM Transactions on Database Systems"}

MACRO {tog} {"ACM Transactions on Graphics"}

MACRO {toms} {"ACM Transactions on Mathematical Software"}

MACRO {toois} {"ACM Transactions on Office Information Systems"}

MACRO {toplas} {"ACM Transactions on Programming Languages and Systems"}

MACRO {tcs} {"Theoretical Computer Science"}

READ

FUNCTION {sortify}
{ purify$
  "l" change.case$
}

INTEGERS { len }

FUNCTION {chop.word}
{ 's :=
  'len :=
  s #1 len substring$ =
    { s len #1 + global.max$ substring$ }
    's
  if$
}

INTEGERS { et.al.char.used }

FUNCTION {initialize.et.al.char.used}
{ #0 'et.al.char.used :=
}

EXECUTE {initialize.et.al.char.used}

FUNCTION {name.van}
{
  "{vv }" format.name$
  "u" change.case$ "t" change.case$
}


FUNCTION {format.lab.names}
{ 's :=
  s num.names$ 'numnames :=
  numnames #2 =
    { #2 'namesleft := }
    { #1 'namesleft := }
  if$
  #1 'nameptr :=
  ""
  { namesleft #0 > }
    { s nameptr "{vv }{ll}" format.name$ *
%  om Van met hoofdletter te creeren, gebruik volgende regel:
%    { s nameptr name.van s nameptr "{ll}" format.name$ * *
      namesleft #2 =
        { " and " * }
        'skip$
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
  numnames #2 >
    { "{\etalchar{+}}" *
      #1 'et.al.char.used :=
    }
    'skip$
  if$
}



FUNCTION {format.lab.full.names.twothree}
{ 's :=
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { s nameptr "{vv }{ll}" format.name$ 't :=
% om Van met hoofdletter te creeren, gebruik volgende regel:
%     { s nameptr name.van s nameptr "{ll}" format.name$ * 't :=
      nameptr #1 >
    { namesleft #1 >
        { ", " * t * }
        { numnames #2 >
        { "," * }
        'skip$
          if$
          t "others" =
        { " et~al." * }
        { " and " * t * }
          if$
        }
      if$
    }
    't
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
}


FUNCTION {format.lab.full.names}
{'s :=
  s num.names$ 'numnames :=
  numnames #4 <
  { s format.lab.full.names.twothree }
  { s format.lab.names }
  if$
}


FUNCTION {author.key.label}
{ author empty$
    { key empty$
    { cite$ #1 #3 substring$ }
    { key #3 text.prefix$ }
      if$
    }
    { author format.lab.names }
  if$
}

FUNCTION {author.key.full.label}
{ author empty$
    { key empty$
    { cite$ #1 #3 substring$ }
    { key #3 text.prefix$ }
      if$
    }
    { author format.lab.full.names }
  if$
}

FUNCTION {author.editor.key.label}
{ author empty$
    { editor empty$
    { key empty$
        { cite$ #1 #3 substring$ }
        { key #3 text.prefix$ }
      if$
    }
    { editor format.lab.names }
      if$
    }
    { author format.lab.names }
  if$
}


FUNCTION {author.editor.key.full.label}
{ author empty$
    { editor empty$
    { key empty$
        { cite$ #1 #3 substring$ }
        { key #3 text.prefix$ }
      if$
    }
    { editor format.lab.full.names }
      if$
    }
    { author format.lab.full.names }
  if$
}

FUNCTION {author.key.organization.label}
{ author empty$
    { key empty$
    { organization empty$
        { cite$ #1 #3 substring$ }
        { "The " #4 organization chop.word #3 text.prefix$ }
      if$
    }
    { key #3 text.prefix$ }
      if$
    }
    { author format.lab.names }
  if$
}

FUNCTION {author.key.organization.full.label}
{ author empty$
    { key empty$
    { organization empty$
        { cite$ #1 #3 substring$ }
        { "The " #4 organization chop.word #3 text.prefix$ }
      if$
    }
    { key #3 text.prefix$ }
      if$
    }
    { author format.lab.full.names }
  if$
}


FUNCTION {editor.key.organization.label}
{ editor empty$
    { key empty$
    { organization empty$
        { cite$ #1 #3 substring$ }
        { "The " #4 organization chop.word #3 text.prefix$ }
      if$
    }
    { key #3 text.prefix$ }
      if$
    }
    { editor format.lab.names }
  if$
}

FUNCTION {editor.key.organization.full.label}
{ editor empty$
    { key empty$
    { organization empty$
        { cite$ #1 #3 substring$ }
        { "The " #4 organization chop.word #3 text.prefix$ }
      if$
    }
    { key #3 text.prefix$ }
      if$
    }
    { editor format.lab.full.names }
  if$
}

FUNCTION {calc.full.label}
{
  type$ "book" =
  type$ "inbook" =
  or
    'author.editor.key.full.label
    { type$ "proceedings" =
    'editor.key.organization.full.label
    { type$ "manual" =
        'author.key.organization.full.label
        'author.key.full.label
      if$
    }
      if$
    }
  if$
  'full.label :=
}

FUNCTION {calc.label}
{ type$ "book" =
  type$ "inbook" =
  or
    'author.editor.key.label
    { type$ "proceedings" =
    'editor.key.organization.label
    { type$ "manual" =
        'author.key.organization.label
        'author.key.label
      if$
    }
      if$
    }
  if$
  duplicate$
  'label :=
  year field.or.null purify$ #-1 #4 substring$
  *
  sortify 'sort.label :=
  year 'year.label :=

}

FUNCTION {sort.format.names}
{ 's :=
  #1 'nameptr :=
  ""
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { nameptr #1 >
    { "   " * }
    'skip$
      if$
%      s nameptr "{vv{ } }{ll{ }}{  ff{ }}{  jj{ }}" format.name$ 't :=
      s nameptr "{ll{ }}{  ff{ }}{  jj{ }}" format.name$ 't :=
      nameptr numnames = t "others" = and
    { "et al" * }
    { t sortify * }
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
}

FUNCTION {sort.format.title}
{ 't :=
  "A " #2
    "An " #3
      "The " #4 t chop.word
    chop.word
  chop.word
  sortify
  #1 global.max$ substring$
}

FUNCTION {author.sort}
{ author empty$
    { key empty$
    { "to sort, need author or key in " cite$ * warning$
      ""
    }
    { key sortify }
      if$
    }
    { author sort.format.names }
  if$
}

FUNCTION {author.editor.sort}
{ author empty$
    { editor empty$
    { key empty$
        { "to sort, need author, editor, or key in " cite$ * warning$
          ""
        }
        { key sortify }
      if$
    }
    { editor sort.format.names }
      if$
    }
    { author sort.format.names }
  if$
}

FUNCTION {author.organization.sort}
{ author empty$
    { organization empty$
    { key empty$
        { "to sort, need author, organization, or key in " cite$ * warning$
          ""
        }
        { key sortify }
      if$
    }
    { "The " #4 organization chop.word sortify }
      if$
    }
    { author sort.format.names }
  if$
}

FUNCTION {editor.organization.sort}
{ editor empty$
    { organization empty$
    { key empty$
        { "to sort, need editor, organization, or key in " cite$ * warning$
          ""
        }
        { key sortify }
      if$
    }
    { "The " #4 organization chop.word sortify }
      if$
    }
    { editor sort.format.names }
  if$
}

FUNCTION {presort}
{ calc.label
  calc.full.label
  type$ "book" =
  type$ "inbook" =
  or
    'author.editor.sort
    { type$ "proceedings" =
    'editor.organization.sort
    { type$ "manual" =
        'author.organization.sort
        'author.sort
      if$
    }
      if$
    }
  if$
  "    "
%  sort.label
%  *
  *
  "    "
  *
  year field.or.null sortify
  *
  "    "
  *
  title field.or.null
  sort.format.title
  *
  #1 entry.max$ substring$
  'sort.key$ :=
}

ITERATE {presort}

SORT

STRINGS { longest.label last.sort.label next.extra }

INTEGERS { longest.label.width last.extra.num }

FUNCTION {initialize.longest.label}
{ "" 'longest.label :=
  #0 int.to.chr$ 'last.sort.label :=
  "" 'next.extra :=
  #0 'longest.label.width :=
  #0 'last.extra.num :=
}

FUNCTION {forward.pass}
{ last.sort.label sort.label =
    { last.extra.num #1 + 'last.extra.num :=
      last.extra.num int.to.chr$ 'extra.label :=
    }
    { "a" chr.to.int$ 'last.extra.num :=
      "" 'extra.label :=
      sort.label 'last.sort.label :=
    }
  if$
}

FUNCTION {reverse.pass}
{ next.extra "b" =
    { "a" 'extra.label := }
    'skip$
  if$
  year.label extra.label * 'year.label :=
  label width$ longest.label.width >
    { label 'longest.label :=
      label width$ 'longest.label.width :=
    }
    'skip$
  if$
  extra.label 'next.extra :=
}

%FUNCTION {reverse.pass}
%{ next.extra "b" =
%    { "a" 'extra.label := }
%    'skip$
%  if$
%  label extra.label * 'label :=
%  label width$ longest.label.width >
%    { label 'longest.label :=
%     label width$ 'longest.label.width :=
%    }
%    'skip$
%  if$
%  extra.label 'next.extra :=
%}


EXECUTE {initialize.longest.label}

ITERATE {forward.pass}

REVERSE {reverse.pass}

FUNCTION {begin.bib}
{ et.al.char.used
    { "\newcommand{\etalchar}[1]{{\noexpand\em ~et~al.}}" write$ newline$ }
    'skip$
  if$
  preamble$ empty$
    'skip$
    { preamble$ write$ newline$ }
  if$
%  "\begin{thebibliography}{"  longest.label  * "}" * write$ newline$
   "\begin{thebibliography}{"  "[100]" * "}" * write$ newline$
}

EXECUTE {begin.bib}

EXECUTE {init.state.consts}

ITERATE {call.type$}

FUNCTION {end.bib}
{ newline$
  "\end{thebibliography}" write$ newline$
}

EXECUTE {end.bib}
%UEND
