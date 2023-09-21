#!/bin/bash
# ============================================================================
#
#      Script de mise à jour des dépots DEBIAN
#
# ============================================================================
# Auteur : Stéphane PRIGENT - PCC
# Date   : 8 Septembre 2023
# ============================================================================

# Variables 
# ----------------------------------------------------------------------------
RACINE=$(dirname $0)
VERSION="bullseye bookworm"
APT_POOL=$1

if [ -z "${APT_POOL}" ] ; then
    echo ""
    echo "Syntaxe : $0 <pool apt>"
    echo "     Ex : $0 /media/DDS123456/apt-mirror"
    echo ""
    exit 2
fi

function download()
{
    local VERSION=$1
    local APT_POOL=$2

    # Vérifier que l'image n'existe pas
    # ------------------------------------------------------------------------
    docker images apt-mirror:${VERSION} | grep -q apt-mirror
    if [ $? -eq 0 ] ; then
        echo ""
        echo "L'image apt-mirror:${VERSION} existe déjà."
        echo "Veillez la supprimer et relancez le script."
        echo ""
        exit 1
    fi

    # Construction du fichier mirror.list
    # ------------------------------------------------------------------------
    cat > ${RACINE}/mirror.list <<EOF 
set base_path /apt-mirror
set nthreads     20
set _tilde        0
deb http://deb.debian.org/debian ${VERSION} main contrib non-free
deb-amd64 http://deb.debian.org/debian ${VERSION} main contrib non-free
deb-src http://deb.debian.org/debian ${VERSION} main contrib non-free
deb http://deb.debian.org/debian ${VERSION}-updates main contrib non-free
deb-src http://deb.debian.org/debian ${VERSION}-updates main contrib non-free
deb http://security.debian.org/debian-security ${VERSION}-security main contrib non-free
deb-src http://security.debian.org/debian-security ${VERSION}-security main contrib non-free
clean http://ftp.fr.debian.org/debian
EOF

    # Création de l'image docker
    # ------------------------------------------------------------------------
    docker build -t apt-mirror:${VERSION} ${RACINE}

    # Exécution du docker
    # ------------------------------------------------------------------------
    docker run --volume=${APT_POOL}/${VERSION}:/apt-mirror apt-mirror:${VERSION}

    # Suppression du docker
    # ------------------------------------------------------------------------
    docker rmi apt-mirror:${VERSION} -f
}

for ver in ${VERSION}; do
    download ${ver} ${APT_POOL}
done
# ============================================================================
