# objectclass-indexing-experiments

Trying to see if there's life after xpat

Background: https://tools.lib.umich.edu/confluence/display/OBC/Experiment%3A+Indexing+Metadata

## About the sample data

The `data` directory contains sample data for six collections.

Each collection directory has max 1000 sample records.

Each file represents a record, is encoded in JSON, where each key is a field, and each value is an array of strings (with one exception).

**Common metadata** is represented by the Dublin Core, and can be recognized by the leading `dc:` namespace, e.g. `dc:title`.

The `dc:memberOf` value is an array of hashes. The hash has a `title` and `href` --- where the `href` starts with `urn:x-umich:group:` the entry represents membership in a DLXS *group*. `urn:x-umich:collection:` represents a DLXS *collection*. At this point, use whichever value you want to tinker with, or punt!

The **collection-specific metadata** are the keys prefixed with the `collid`, e.g. `bhl:bhl_ti`.

