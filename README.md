# Cosign + GitHub Actions

The goal of this repository is to demonstrate how you can use [cosign](https://github.com/sigstore/cosign) with GitHub Actions.

## Setup

`cosign` has an integration for GitHub, i.e.,

```shell
cosign generate-key-pair "github://username/projectname"
```

... will ...

- generate a public/private key pair,
- store the public key as a GitHub Secret with the name `COSIGN_PUBLIC_KEY` and, additionally, in a file called `cosign.pub`.
- store the private key as a GitHub Secret with the name `COSIGN_PRIVATE_KEY`
- store the password to use as a GitHub Secret with the name `COSIGN_PASSWORD`

To do so, it needs `repo` access to the GitHub API.
Thus, you need to create an access token with the scope `repo`.

After you have created the token, you can use this snippet to generate the key pair.

```shell
#!/bin/bash
COSIGN_PASSWORD="" # This parameter contains the password for the private key to generate
GITHUB_TOKEN="" # You have to create an Access Token with repo access.
GITHUB_REPOSITORY="" # The GitHub repository, i.e., username/projectname.

export COSIGN_PASSWORD
export GITHUB_REPOSITORY
export GITHUB_TOKEN

cosign generate-key-pair "github://${GITHUB_REPOSITORY}"
```

## Container Image Signing

Have a look at [Sign image with a key](/.github/workflows/build-images.yml#L55).
Here, we use the private key in the `COSIGN_PRIVATE_KEY` environment variable to sign the container image.

Have a look at [this signing job](https://github.com/pstoeckle/cosign-test/actions/runs/8258165241/job/22589926318) to see the script in action.

Afterward, you can see the result, i.e., a `sha256-[0-9a-f]{64}.sig` file in the [container registry](https://github.com/pstoeckle/cosign-test/pkgs/container/test-image).

## Container Image Verification

To verify the signature of a container image, you need the public key.
We stored the public key in [cosign.pub](./cosign.pub).

Have a look at [Verify the signatures with the public key in the repository](/.github/workflows/build-images.yml#L90).

Have a look at [this verify job](https://github.com/pstoeckle/cosign-test/actions/runs/8263549390/job/22605231457) to see the script in action.

## Contact

You can contact via Email

- [Patrick Stöckle](https://github.com/pstoeckle)

Or you can create an [issue](https://github.com/pstoeckle/cosign-test/issues).
