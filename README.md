# Missing Science Packs

[![FACTORIO](https://img.shields.io/badge/dynamic/json?color=orange&label=Factorio&query=downloads_count&suffix=%20downloads&url=https://mods.factorio.com/api/mods/missing-science-packs&logo=data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAACGVBMVEUAAAABAAAAAQAAAAEBAQEAAQEBAQDYhDvehje8eDmAgYDShj+ZZjPfhTfDdTiPUyvrkDynZTDafTTSeziCTSqeZzK2dTXWgT2NUzSAgQCMWjhtRjTVfTZ3QyJBQEDefzRrLA1gLQdwLASFOQtPLinkjELLeDZtLwxJJBKWPQ+cSxtkMiJdOiP1kz1XIgawYy2STyZlPi63dDpxRCVeIQbFjlVXOSmcbDusbjZ4Mgx2OhS/YCHTpW5GIhRnOhtDLCW2czeEOg+FNA2oYy7KllwnGhbNZjK/dTYpHxh9UTFOKhiAAQFIMCY3IhcdEg4oHBkpGxUZEBFbNhsvIh95RSFpOhsbDQ0AAQAyIxkAAABJMyQqIh4oHBq2bCzgijunZTSfViqtYy2yfU2udT6xay2zaiu3aii1aC2gXCynWiiuYiuYWS2qc0e5eD25bCqjYSmcWiSdVyO1aCulYyqZVCaXSR24dT2yaCmXVCWlXSevZiqFRSDEgEivaS2YXyyvZCqnYCq2bzGseUWpZSqJVSexajKyZyh/Ox2SYDaiZSqVVSaybje2aCmCPBiqYSacYSqlZCzBayurYSmdXy2vaSmfWia6dz66ayZyPh6NUyekXCamZiqrZSyoYSu3bTO7aCvFbiehVyNNJxdvSCuaXClLKRd/SSOiYSm6bSu5aii0YiaHQxxxPBySVidHJxlzOx1YLRdTOCGeXii5isPXAAAAXXRSTlMAAAAAAAAAcN1nAlUFF8mflsS//v64O12UAmBUPcEEv9t6e9+7aKHaDhHf/RbeeH7Cb27Hd3zjGv7YDRDd/ppnxNp4edy2BcYzWFQClFg2ufy6vo6gwBQDUQFp32wXrE9IAAAAvElEQVQYGQXBPyuEAQAH4N/zXlJKdimTstxCBouRSOjcnzK4T6ZEce+dk7AwGQ0m020WMSulnLvzPJIkJtP8JDKRzPA9a//2K0XGFTG3d8eue/Apmd8C4OZDsnAAoONdstiigyblWyxpUhpY1tAzUK2j+1qMi2qTkhUNui9JsdpER7GmpfScdQ09pNg45Ao1+k9D2VQDcPEwke0jAE4e/9iBNqe0z64jpn4ro/rxuX6dy4hiVIyPKIcmSf4BuN02xRLLCCIAAAAASUVORK5CYII=)](https://mods.factorio.com/mod/missing-science-packs) [![COMMUNITY](https://img.shields.io/badge/Discord-Community-blue?logo=discord)](https://discord.gg/FcFEu36QBc) [![GitHub](https://img.shields.io/badge/Github-Source-white?logo=github)](https://github.com/Eldrinn-Elantey/missing-science-packs)

Shows under the research bar which science packs your labs lack for the current research, with the number of stalled labs next to each pack. You see that green packs stopped reaching 12 labs without walking the lab rows.

## What it does

- Lists each missing pack of the current research with the count of labs waiting for it
- Skips labs that cannot take every pack of the current research, so a modded lab with a short pack list does not inflate the count
- Skips empty labs, since you usually leave those unsupplied on purpose
- Updates once a second and right after you start, finish or cancel a research

The row sits in extra space the mod adds under the research bar. That space stays there even when nothing is missing.

Inspired by [Show missing bottles for current research](https://mods.factorio.com/mod/show-missing-bottles-for-current-research) by Quezler.
