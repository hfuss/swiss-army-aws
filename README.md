# swiss-army-aws

It works on OpenShift 3.11 unlike `amazon/aws-cli`...

Tested with :heart: using [`kiam`](https://github.com/uswitch/kiam).

Running something like:

```bash
$ oc run \
  --rm \
  --restart=Never \
  --image-pull-policy=Always \
  --overrides '{ "metadata": { "annotations": { "iam.amazonaws.com/role": "arn:aws:iam::1234:role/a-role" } } }' \
  -n kiam-test \
  --image brix4dayz/swiss-army-aws \
  -it debug \
  -- sts get-caller-identity
``` 

should yield something like:
```
If you dont see a command prompt, try pressing enter.
Creating user entry in /etc/passwd
Created user entry in /etc/passwd
{
    "Account": "1234", 
    "UserId": "AROA5BAVQINTYSDFBHB:kiam-kiam", 
    "Arn": "arn:aws:sts::1234:assumed-role/a-role/kiam-kiam"
}
pod "debug" deleted
```
